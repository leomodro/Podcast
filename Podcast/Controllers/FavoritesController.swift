//
//  FavoritesController.swift
//  Podcast
//
//  Created by Leonardo Modro on 22/03/2018.
//  Copyright © 2018 Leonardo Modro. All rights reserved.
//

import UIKit

class FavoritesController: UICollectionViewController {
    
    let cellId = "cellId"
    var podcasts = UserDefaults.standard.savedPodcast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        podcasts = UserDefaults.standard.savedPodcast()
        collectionView?.reloadData()
        UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = nil
    }
    
    //MARK: - Collection View
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(FavoritePodcastCell.self, forCellWithReuseIdentifier: cellId)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView?.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        guard let selectedIndexPath = collectionView?.indexPathForItem(at: location) else { return }
        
        let alertController = UIAlertController(title: "Remove Podcast", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            let selectedPodcast = self.podcasts[selectedIndexPath.item]
            self.podcasts.remove(at: selectedIndexPath.item)
            self.collectionView?.deleteItems(at: [selectedIndexPath])
            UserDefaults.standard.deletePodcast(podcast: selectedPodcast)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoritePodcastCell
        cell.podcast = podcasts[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episodes = EpisodesController()
        episodes.podcast = self.podcasts[indexPath.row]
        navigationController?.pushViewController(episodes, animated: true)
    }
}

//MARK: -
extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 16) / 2
        return CGSize(width: width, height: width + 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
