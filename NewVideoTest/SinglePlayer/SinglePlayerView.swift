//
//  SinglePlayerView.swift
//  NewVideoTest
//
//  Created by papyrus on 9/5/17.
//  Copyright © 2017 SixthSolution. All rights reserved.
//

import UIKit

class SinglePlayerView: UIViewController {

    var videoId: String!
    var player: YouTubePlayerView!
    
    var playTimer: Timer? = nil
    
    var isViewVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(player)
        
        player.delegate = self
        
        print(videoId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isViewVisible = true
        
        //player.play()
        if player.ready {
            player.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isViewVisible = false
        
        player.pause()
        if playTimer != nil {
            playTimer?.invalidate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        player.play()
        print("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        player.pause()
        print("viewDidDisappear")
    }
    
}

extension SinglePlayerView: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("playerReady")
        
        videoPlayer.play()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
        if playerState == YouTubePlayerState.Playing {
            if !isViewVisible {
                videoPlayer.pause()
                videoPlayer.seekTo(0, seekAhead: true)
                return
            }
            
            videoPlayer.scheduledTimer(duration: SinglePlayerVC.playDuration)
        }
    }

}
