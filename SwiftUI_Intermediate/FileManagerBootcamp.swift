//
//  FileManagerBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 10.08.23.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder: \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting data."
            
        }
        
        //let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let directory = FileManager.default.temporaryDirectory
                
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        } catch let error {
            return"Error saving: \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            return "Error getting path."
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            return "Successfully deleted"
        } catch let error {
            return "Error deleting image: \(error)"
        }
    }
    
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path.")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName = "steve-jobs"
    let manager = LocalFileManager.instance
    @Published var infoMessage = ""
    
    init() {
        getImageFromAssetsFolder()
        //getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject private var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)

                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
