import Foundation
import UIKit

/**
 
 The easiest way to take or select a picture in iOS, because it shouldn't take an hour
 USAGE:
 EasyCam.shared.showActionSheet(vc: self)
 EasyCam.shared.imagePickedBlock = { (image) in
    self.image?.image = image
 }
 
 */
public class EasyCam: NSObject{
    
    private static let _shared = EasyCam()
    public static var shared:EasyCam {
        get {
            return _shared
        }
    }
    internal var currentVC: UIViewController!
    
    //MARK: Internal Properties
    public var imagePickedBlock: ((UIImage) -> Void)?
    var _autoCorrect:Bool = true
    var autoCorrect:Bool {
        get {
            return self._autoCorrect
        }
        set(newVal) {
            _autoCorrect = newVal
        }
    }
    
    public override init() {
        super.init()
    }
    
    //Use the camera
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //Use the photo library picker
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //Show the action sheet
    public func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true, completion: nil)
    }
}


extension EasyCam: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Image cancelled
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    //Image gotted either through camera or the image picker
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if var image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if(self._autoCorrect == true) {
                var inputImage = CIImage(image:image)
                let filters = inputImage?.autoAdjustmentFilters()
                for filter:CIFilter in filters! {
                    filter.setValue(inputImage, forKey:kCIInputImageKey)
                    inputImage = filter.outputImage!
                }
                image = UIImage(ciImage: inputImage!)
            }
            
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}

