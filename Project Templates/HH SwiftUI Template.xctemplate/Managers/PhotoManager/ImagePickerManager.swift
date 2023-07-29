//___FILEHEADER___

import PhotosUI
import SwiftUI

struct ImagePickerManager: UIViewControllerRepresentable {
    
    @Binding var image: [UIImage?]
    var filter: PHPickerFilter = .images
    var selectionLimit: Int = 0

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = self.filter
        config.selectionLimit = self.selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        
        let parent: ImagePickerManager

        init(_ parent: ImagePickerManager) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            let imageItems = results.map { $0.itemProvider }
                .filter { $0.canLoadObject(ofClass: UIImage.self) }
            
            for imageItem in imageItems {
                imageItem.loadObject(ofClass: UIImage.self) { image, error in
                    guard let image = image as? UIImage else { return }
                    
                    self.parent.image.append(image)
                }
            }
        }
        
    }
    
}
