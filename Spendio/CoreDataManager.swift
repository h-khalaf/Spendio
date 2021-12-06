//
//  CoreDataManager.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-01.
//

import Foundation
import CoreData

struct CoreDataManager {
    let controller = PersistenceController.shared
    
    func save() throws {
        let context = controller.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                throw error
            }
        }
    }
    
    func addCategory(name: String, color: [Float]) throws {
        let context = controller.container.viewContext
        
        let newCategory = Category(context: context)
        newCategory.name = name
        newCategory.colorRed = color[0]
        newCategory.colorGreen = color[1]
        newCategory.colorBlue = color[2]
        
        try self.save()
    }
    
     func fetchAllCategories() throws -> [Category]  {
         let context = controller.container.viewContext
         
         let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
         let categories = try context.fetch(fetchRequest)
         return categories
    }
    
    func updateCategory (category: Category, name: String, color: [Float]) throws {
        category.name = name
        category.colorRed = color[0]
        category.colorGreen = color[1]
        category.colorBlue = color[2]
        
        try self.save()
    }
    
    func deleteCategory(category: Category) throws {
        let context = controller.container.viewContext
        context.delete(category)
        
        try self.save()
    }
    
    func addExpense(title: String, price: Double, date: Date, currency: String) throws {
        let context = controller.container.viewContext
        
        let newExpense = Expense(context: context)
        newExpense.title = title
        newExpense.price = price
        newExpense.date = date
        newExpense.currency = currency
        //newExpense.category = Category()
        
        try self.save()
    }
    
    func fetchRecentExpenses(limit: Int) throws -> [Expense]  {
        let context = controller.container.viewContext
        
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
       
        let expenses = try context.fetch(fetchRequest)
        return expenses
   }
}
