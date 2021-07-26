//
//  TrackCollectionHeaderView.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
  
    
    var item: AVPlayerItem?
    
    // 버튼을 탭했을때 오늘의 곡 인스턴스를 바탕으로 플레이뷰를 리턴값없이 보여줄거야
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    @IBAction func cardTapped(_ sender: UIButton) {
        // 아이템 확인
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem) {
        self.item = item
        
        guard let track = item.convertToTrack() else { return }
        
        self.thumbnailImageView.image = track.artwork
        self.descriptionLabel.text = "Today's pick is \(track.artist)'s album - \(track.albumName), Let's listen."
    }
    

}
