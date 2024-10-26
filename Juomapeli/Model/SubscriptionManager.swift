//
//  SubscriptionManager.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.10.2024.
//

import Foundation
import StoreKit

struct SubscriptionManager {
    
    //MARK: - Fetch products from AppStore
    
    func fetchProducts() async -> [Product] {
        
        let productIDs = ["weeklySubscription","monthlySubscription","yearlySubscription"]
        
        do {
            let products = try await Product.products(for: productIDs).sorted(by: { $0.price > $1.price })
            return products
        } catch {
            // Handle any errors during the fetch
            print("Failed to fetch products: \(error)")
            return []
        }
    }
    
    //MARK: - Buy product
    
    func buyProduct(_ product: Product) async {
        let subData = SubscriptionData()
        guard var productIDArray = subData.fetchIDArray() else { return }
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case let .success(.verified(transaction)):
                // Successful purhcase
                productIDArray.append(product.id)
                UserDefaults.standard.set(productIDArray, forKey: "plusVersionSubIDs")
                await transaction.finish()
            case let .success(.unverified(_, error)):
                // Successful purchase but transaction/receipt can't be verified
                // Could be a jailbroken phone
                print("Unverified purchase. Might be jailbroken. Error: \(error)")
                break
            case .pending:
                // Transaction waiting on SCA (Strong Customer Authentication) or
                // approval from Ask to Buy
                break
            case .userCancelled:
                // ^^^
                print("User Cancelled!")
                break
            @unknown default:
                print("Failed to purchase the product!")
                break
            }
        } catch {
            print("Failed to purchase the product!")
        }
    }
    
    func restorePurchases() async {
            do {
                try await AppStore.sync()
            } catch {
                print(error)
            }
        }
}

struct SubscriptionData {
        
        func generateArray() {
            let key = "plusVersionSubIDs"
            let array: [String] = []
            
            if UserDefaults.standard.array(forKey: key) == nil {
                // Save the array if it does not exist
                UserDefaults.standard.set(array, forKey: key)
                print("Array saved to UserDefaults.")
            } else {
                print("Array already exists. Skipping save.")
            }
        }
        
        func fetchIDArray() -> [String]? {
            return UserDefaults.standard.array(forKey: "plusVersionSubIDs") as? [String]
        }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                print("User has an unverified purchase: ")
                continue
            }
            if transaction.revocationDate == nil {
                print("User has an active purchase")
                print(transaction.productID)
            } else {
                print("User has a revoked purchase")
                if let currentSubsArray = fetchIDArray() {
                    let revokedPurchaseID = transaction.productID
                    let updatedSubsArray = currentSubsArray.filter { $0 != revokedPurchaseID }
                    UserDefaults.standard.set(updatedSubsArray, forKey: "plusVersionSubIDs")
                }
            }
        }
    }
}
