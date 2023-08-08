//
//  CoreDataRelatoinshipsBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 08.08.23.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading CoreData: \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error while saving error: \(error)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var businesses = [BusinessEntity]()
    
    init() {
        getBusinesses()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        request.sortDescriptors = []
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error while fetching from CoreData: \(error)")
        }
    }
    
    func addBusiness(name: String) {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = name
        
        // add existing departments to the new business
        
        
        save()
        getBusinesses()
    }
    
    func addDepartment(name: String) {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = name
        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func save() {
        businesses.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
        }
        manager.save()
    }
}

struct CoreDataRelatoinshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.addBusiness(name: "Apple")
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelatoinshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelatoinshipsBootcamp()
    }
}


struct BusinessView: View {
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(.gray)
        .opacity(0.5)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
