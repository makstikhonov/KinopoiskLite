//
//  DetailViewController.swift
//  iOSCourseWork1
//
//  Created by max on 01.03.2022.
//  Copyright © 2022 Ildar Zalyalov. All rights reserved.
//

import UIKit
import AVKit

struct DetailViewControllerConfiguration {
    var data: FilmData
    var cellIndexPath: IndexPath
    var isEditMode: Bool
}

protocol DetailViewControllerDelegate: AnyObject {
    func updateImageAndDescription(updatedFilm: FilmData, indexPath: IndexPath)
}

class DetailViewController: UIViewController, ImagePickerDelegate {
    
    weak var delegate: DetailViewControllerDelegate?

    @IBOutlet weak private var fullImageView: UIImageView!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var fullDescriptionTextView: UITextView!
    @IBOutlet weak private var shareButton: UIButton!

    
    var configuration: DetailViewControllerConfiguration!
    private var isEditMode = false
    private var imagePicker: ImagePicker!
    private var fullImageViewName = ""
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        fullImageView.image = configuration.data.getImage(from: configuration.data.imageName)
        releaseDateLabel.text = dateFormatter.dateToString(date: configuration.data.date ?? Date())
        fullDescriptionTextView.text = configuration.data.description
        
        fullDescriptionTextView.isEditable = false
        fullDescriptionTextView.layer.cornerRadius = Metrics.fullDescriptionTextViewCornerRadius
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
        fullImageView.isUserInteractionEnabled = true
        fullImageView.addGestureRecognizer(tapGesture)
        fullImageView.layer.cornerRadius = Metrics.fullImageViewCornerRadius
        
        if configuration.isEditMode == false {
            editButton.isHidden = true
        }
    }
    //MARK:share button action
    /// Function shares desctiption and image of the film
    @IBAction func shareTextAndImage(_ sender: Any) {
        
        let shareAll = [ fullDescriptionTextView.text!, fullImageView.image! ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    //MARK:videoplayer
    @objc
    /// Function opens videoplayer when user taps on the image
    func didTapOnImage() {
        
        if isEditMode == true {
            self.imagePicker.present(from: self.view)
        } else {
            guard let path = Bundle.main.path(forResource: configuration.data.pathToVideo, ofType: Metrics.videoType) else {
                debugPrint(Metrics.videoPlayerError)
                return
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let vc = AVPlayerViewController()
            vc.player = player
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
    }
    //MARK: change description and text
    /// Function edits description and image of the film
    /// - Parameter sender:
    @IBAction func editDescriptionAndImage(_ sender: Any) {
        
        if isEditMode == false {
            isEditMode = true
            fullDescriptionTextView.isEditable = true
            editButton.setTitle(Metrics.editButtonSaveTitle, for: .normal)
            editButton.tintColor = .systemPink
        } else {
            isEditMode = false
            fullDescriptionTextView.isEditable = false
            editButton.setTitle(Metrics.editButtonTitle, for: .normal)
            
            configuration.data.description = fullDescriptionTextView.text
            configuration.data.imageName = (fullImageView.image?.jpeg)!
        
            delegate?.updateImageAndDescription(updatedFilm: configuration.data, indexPath: configuration.cellIndexPath)
            navigationController?.popViewController(animated: true)
        }
    }
    /// Function assigns a picture to the fullImageView, when  the user pickes image in the ImagePicker
    /// - Parameter image: picked image
    func didSelectImage(image: UIImage?) {
        if image != nil {
            fullImageView.image = image
        }
    }
}

extension DetailViewController {
    enum Metrics {
        static let fullDescriptionTextViewCornerRadius: CGFloat = 10
        static let fullImageViewCornerRadius: CGFloat = 10
        static let videoType: String = "mp4"
        static let videoPlayerError: String = "video not found"
        static let editButtonSaveTitle: String = "Save"
        static let editButtonTitle: String = "Edit"
    }
}

