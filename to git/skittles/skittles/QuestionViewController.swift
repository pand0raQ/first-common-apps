//
//  QuestionViewController.swift
//  QuizzerDemo
//
//  Created by Stephen Lu on 12/14/14.
//  Copyright (c) 2014 LineBreak. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var score: Int!
    var done: Bool = false
    
    @IBOutlet var ScoreView: UITextView!
    
    
    @IBAction func `true`(_ sender: AnyObject) {
    }
    
    @IBAction func `false`(_ sender: AnyObject) {
    }
    var questionViews: [QuestionView] = []
    var currentQuestionView:QuestionView!
    
    //Data which store string- bool
    
    
    var data: [(String, Bool)]=[
        ("The orange candy - Watermelon flavour?", false),
        ("The red candy - Orange Flavour?", false),
        ("The green candy - Watermelon Flavour?", true),
        ("The blue candy - Limon Flavour?", true),
        ("The Skittles - The best candy in the world?",true),
        ("Спонсор- Скитлс)))",true),
        ("И да, Я ХЗ как убрать надпись снизу ОПТИОНАЛ((((( ",true),
        ("И из сфита убрали обжектив-с, приходилось заменять элементы обЪектив",true),
        ("Чувак написал код 3года назад, с тех пор свифт обновлялся много раз",true),
        ("Свайп направо-утвержение верное налево-пффф мемы внизу для чего бл.",true),
        ("Крч тут как бы будут появляться вопросы на забугорском",true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start with 0 score
        
        
        score = 0
        
        for(question,answer) in self.data{
            currentQuestionView = QuestionView(
                frame: CGRect(x: 0, y: 0, width: 50, height: 50),
                question: question,
                answer: answer,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.questionViews.append(currentQuestionView)
        }
        for questionViews in self.questionViews {
            self.view.addSubview(questionViews)
        }
        
        
        // Add Pan Gesture Recognizer
        
        
        
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(QuestionViewController.handlePan(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    func determineJudgement(_ answer: Bool) {
        
        // If its the right answer, set the score
        if self.currentQuestionView.answer == answer && !self.done{
            self.score = self.score + 1
            self.ScoreView.text = "Score: \(self.score)"
        }
        
        // Run the swipe animation
        self.currentQuestionView.swipe(answer)
        
        // Handle when we have no more matches
        self.questionViews.remove(at: self.questionViews.count - 1)
        if self.questionViews.count - 1 < 0 {
            let noMoreView = QuestionView(
                frame: CGRect(x: 0, y: 0, width: 50, height: 50),
                question: "No More Questions :(",
                answer: false,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.questionViews.append(noMoreView)
            self.view.addSubview(noMoreView)
            self.done = true
            return
        }
        
        // Set the new current question to the next one
        
        
        self.currentQuestionView = self.questionViews.last!
        
    }
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        // Is this gesture state finished??
        
        
        if gesture.state == UIGestureRecognizerState.ended {
            // Determine if we need to swipe off or return to center
            
            let location = gesture.location(in: self.view)
            if self.currentQuestionView.center.x / self.view.bounds.maxX > 0.8 {
                self.determineJudgement(true)
            }
            else if self.currentQuestionView.center.x / self.view.bounds.maxX < 0.2 {
                self.determineJudgement(false)
            }
            else {
                self.currentQuestionView.returnToCenter()
            }
        }
        let translation = gesture.translation(in: self.currentQuestionView)
        self.currentQuestionView.center = CGPoint(x: self.currentQuestionView!.center.x + translation.x, y: self.currentQuestionView!.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
}
