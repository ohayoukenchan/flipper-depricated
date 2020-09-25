//
//  GameViewController.swift
//  flipper
//
//  Created by  ohayoukenchan on 2020/04/22.
//  Copyright © 2020  ohayoukenchan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

import opencv2

class GameViewController: UIViewController {

    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var dstImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "nino")!

        self.srcImageView.image = image
        self.dstImageView.image = self.convertColor(source: image)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func convertColor(source srcImage: UIImage) -> UIImage {
        let srcMat = Mat(uiImage: srcImage)
        let dstMat = Mat()
        Imgproc.cvtColor(src: srcMat, dst: dstMat, code: .COLOR_RGB2GRAY)
        return dstMat.toUIImage()
    }
}
