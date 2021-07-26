//
//  ViewController.swift
//  MusicPlayApp
//
//  Created by 김지호 on 2021/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

let trackManager = TrackManager()



extension HomeViewController : UICollectionViewDataSource{
    // 섹션마다 아이템 개수 설정 섹셕은 총 두개 아이템은 일단 보자~
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    // 콜렉션의 셀이 들어갈 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollecionViewCell", for: indexPath)  as? TrackCollecionViewCell else {
            return UICollectionViewCell()
        }
        let track = trackManager.track(at: indexPath.item)
        cell.updateUI(item: track)
        return cell
        
    }
    // 헤더 뷰 와 풋터 뷰를 구현할때 필요함
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todaysTrack else {
                return UICollectionReusableView()
            }
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            // TODO: 헤더 구성
            header.update(with: item)
            header.tapHandler = { item -> Void in
                //play를 띄운다
                print("----> item title : \(item.convertToTrack()?.title)")
                
                let playerStoryboard = UIStoryboard.init(name: "Play", bundle: nil)
                
                // play스토리 보드와 연결되있는 컨트롤러 인스턴스 생성 및 present 하기
                //        let playVC: PlayerViewController
                guard let playVC = playerStoryboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else { return }
                // play컨트롤러에 트랙  AVPlayerItem 인스턴스 전달
                playVC.simplePlayer.replaceCurrentItem(with: item)
                self.present(playVC, animated: true, completion: nil)
                
                
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 곡 클릭시 인덱스에 따라 트랙 리스트의 음원이 재생 되어야 한다.
        print("---> \(indexPath.item)")
        // play 스토리 보드 가져오기
        let playerStoryboard = UIStoryboard.init(name: "Play", bundle: nil)
        
        // play스토리 보드와 연결되있는 컨트롤러 인스턴스 생성 및 present 하기
        //        let playVC: PlayerViewController
        guard let playVC = playerStoryboard.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else { return }
        // play컨트롤러에 트랙  AVPlayerItem 인스턴스 전달
        let item = trackManager.tracks[indexPath.item]
        playVC.simplePlayer.replaceCurrentItem(with: item)
        self.present(playVC, animated: true, completion: nil)
        
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Asks the delegate for the size of the specified item’s cell.
        let itemSpacing : CGFloat = 20 // 아이템 간의 간격
        let margin : CGFloat = 20 // 양쪽 마진 20
        let cellWidth = (collectionView.bounds.width - itemSpacing - (margin * 2)) / 2
        let cellHeight = cellWidth + 60
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

