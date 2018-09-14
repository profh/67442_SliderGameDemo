//
//  ViewController.swift
//  SliderGameDemo
//
//  Created by Larry Heimann on 9/4/18.
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Game object
  let game = Game()
  
  // MARK: - Outlets
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateLabels()
    setupCustomSlider()
  }
  
  
  // MARK: - Actions
  @IBAction func showAlert() {
    let title = game.determineTitle()
    let message = game.generateMessage()
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Ok", style: .default, handler: {
      action in self.startNewRound()
                self.updateLabels()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let currentValue = lroundf(slider.value)
    game.currentValue = currentValue
  }
  
  @IBAction func startOver() {
    game.startNewGame()
    updateLabels()
  }
  
  // MARK: - Game fns
  func startNewRound() {
    game.calculateScore()
    game.startNewRound()
    slider.value = Float(game.currentValue)
  }
  
  func updateLabels() {
    targetLabel.text = String(game.targetValue)
    roundLabel.text = String(game.round)
    scoreLabel.text = String(game.score)
  }
  
  func setupCustomSlider() {
    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
    slider.setThumbImage(thumbImageNormal, for: UIControlState())
    
    let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
    if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
      let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackLeftResizable, for: UIControlState())
    }
    if let trackRightImage = UIImage(named: "SliderTrackRight") {
      let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
      slider.setMaximumTrackImage(trackRightResizable, for: UIControlState())
    }
  }
  
  
  
  // MARK: - Misc
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}

