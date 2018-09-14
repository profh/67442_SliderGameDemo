//
//  GameTests.swift
//  SliderGameDemoTests
//
//  Created by Larry Heimann on 9/4/18.
//  Copyright © 2018 Larry Heimann. All rights reserved.
//

import XCTest
@testable import SliderGameDemo

class GameTests: XCTestCase {
  
  let game = Game()
    
    override func setUp() {
        super.setUp()
        game.startNewGame()
    }
  
  func testStartNewGame() {
    game.startNewGame()
    XCTAssertEqual(game.score, 0)
    XCTAssertEqual(game.round, 1)
    XCTAssertEqual(game.currentValue, 50)
  }
  
  func startNewRound() {
    game.startNewRound()
    XCTAssertEqual(game.currentValue, 50)
    XCTAssertEqual(game.round, 2)
    XCTAssertTrue(game.targetValue < 101)
    XCTAssertTrue(game.targetValue > 0)
  }

  func testCalculateScore() {
    
    // test direct hit
    game.targetValue = 60
    game.currentValue = 60
    game.calculateScore()
    XCTAssertEqual(game.score, 200)
    
    // test hit off by only +1
    game.startNewGame()  // restart the game so score back to zero
    game.targetValue = 60
    game.currentValue = 59
    game.calculateScore()
    XCTAssertEqual(game.score, 149)
    
    // test hit off by more than +1
    game.startNewGame()
    game.targetValue = 60
    game.currentValue = 55
    game.calculateScore()
    XCTAssertEqual(game.score, 95)
    
    // test hit off by only -1
    game.startNewGame()
    game.targetValue = 60
    game.currentValue = 61
    game.calculateScore()
    XCTAssertEqual(game.score, 149)
    
    // test hit off by more than -1
    game.startNewGame()
    game.targetValue = 60
    game.currentValue = 70
    game.calculateScore()
    XCTAssertEqual(game.score, 90)
  }
  
  func testDetermineTitle() {
    
    // test direct hit title
    game.targetValue = 60
    game.currentValue = 60
    XCTAssertEqual(game.determineTitle(), "Perfect!")
    
    // test off by 4 title
    game.targetValue = 60
    game.currentValue = 56
    XCTAssertEqual(game.determineTitle(), "You almost had it!")
    
    // test off by 9 title
    game.targetValue = 60
    game.currentValue = 51
    XCTAssertEqual(game.determineTitle(), "Pretty good!")
    
    // test off by 10 title
    game.targetValue = 60
    game.currentValue = 50
    XCTAssertEqual(game.determineTitle(), "Not even close...")
  }
  
  func testGenerateMessage() {
    
    game.targetValue = 60
    game.currentValue = 40
    let msg = "The value of the slider is: \(game.currentValue) \nThe target value is: \(game.targetValue)"
    XCTAssertEqual(game.generateMessage(), msg)
  }
    
}
