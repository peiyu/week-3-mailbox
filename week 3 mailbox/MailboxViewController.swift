//
//  MailboxViewController.swift
//  week 3 mailbox
//
//  Created by Peiyu Liu on 11/4/15.
//  Copyright © 2015 Peiyu Liu. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {


    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var scheduleView: UIView!

    @IBOutlet weak var rightIconContainerView: UIView!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!

    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    
    var messageOriginalCenter: CGPoint!
    var iconContainerOriginalCenter: CGPoint!
    var rightIconContainerOriginalCenter: CGPoint!
    var feedOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedScrollView.contentSize = CGSize(width: 320, height: 1309)
        deleteIconView.alpha = 0
        listIconView.alpha = 0
        scheduleView.alpha = 0
        feedOriginalCenter = feedView.center
        
        
        

        // Do any additional setup after loading the view.
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        view.userInteractionEnabled = true
        
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        

        
        if sender.state == UIGestureRecognizerState.Began{
            messageOriginalCenter = messageView.center
            iconContainerOriginalCenter = iconContainerView.center
            rightIconContainerOriginalCenter = rightIconContainerView.center

            messageContainerView.backgroundColor = UIColor.grayColor()
            
        }
        else if sender.state == UIGestureRecognizerState.Changed{
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y:messageOriginalCenter.y)
            
            print("center.x \(messageView.center.x)")
            
            
            if messageView.center.x <= -30{
                messageContainerView.backgroundColor = UIColor.brownColor()
                rightIconContainerView.center = CGPoint(x: rightIconContainerOriginalCenter.x + translation.x + 60, y: rightIconContainerOriginalCenter.y)
                
                listIconView.alpha = 1
                laterIconView.alpha = 0
                
                //brown
            }
                
            else if messageView.center.x <= 100 && messageView.center.x > -30{
                rightIconContainerView.center = CGPoint(x: rightIconContainerOriginalCenter.x + translation.x + 60, y: rightIconContainerOriginalCenter.y)
                messageContainerView.backgroundColor = UIColor.orangeColor()
                //messageContainerView.backgroundColor = UIColor.init(red: 248, green: 208, blue: 53, alpha: 1)
                //custom yellow
            }
            
            else if messageView.center.x <= 220 && messageView.center.x > 160{
                messageContainerView.backgroundColor = UIColor.grayColor()
                
                archiveIconView.alpha = convertValue(self.messageView.center.x, r1Min: 160, r1Max: 220, r2Min: 0, r2Max: 1)

            //grey left
            
                
                
            }else if messageView.center.x <= 160 && messageView.center.x > 100 {
                
                laterIconView.alpha = convertValue(messageView.center.x, r1Min: 160, r1Max: 100, r2Min: 0, r2Max: 1)
                
                //grey right
            } else if messageView.center.x > 220 && messageView.center.x<=360{
                messageContainerView.backgroundColor = UIColor.greenColor()
                iconContainerView.center = CGPoint(x: iconContainerOriginalCenter.x + translation.x - 60, y: iconContainerOriginalCenter.y)
                deleteIconView.alpha = 0
                archiveIconView.alpha = 1

                //green
                
            }else {
                messageContainerView.backgroundColor = UIColor.redColor()
                iconContainerView.center = CGPoint(x: iconContainerOriginalCenter.x + translation.x - 60, y: iconContainerOriginalCenter.y)
                deleteIconView.alpha = 1
                archiveIconView.alpha = 0
                
                //red
                
            }
            
        }
        else if sender.state == UIGestureRecognizerState.Ended{
            if messageView.center.x <= -30 {
            //list
            }
            
            else if messageView.center.x <= 100 && messageView.center.x > -30{
            //reschedule
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = -160
                    self.rightIconContainerView.center.x = -120
                    self.messageContainerView.frame = CGRectMake(self.messageContainerView.frame.origin.x, self.messageContainerView.frame.origin.y, 320, 0)
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.feedView.center.y = self.feedOriginalCenter.y - 86
                            }, completion: { (Bool) -> Void in
                                UIView.animateWithDuration(0.4, animations: { () -> Void in
                                    self.scheduleView.alpha = 1
                                })
                                
                        })
                })
                
               
            }
            
            else if messageView.center.x <= 220 && messageView.center.x > 100{
                //default
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.messageView.center.x = self.messageOriginalCenter.x
                    self.iconContainerView.center.x=self.iconContainerOriginalCenter.x
                    self.deleteIconView.alpha = 0
                    self.archiveIconView.alpha = 1
                })
            
            }

                
            else if messageView.center.x > 220 && messageView.center.x<=360{
                //archive

                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.iconContainerView.center.x=440
                    self.messageContainerView.frame = CGRectMake(self.messageContainerView.frame.origin.x, self.messageContainerView.frame.origin.y, 320, 0)
                   
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                             self.feedView.center.y = self.feedOriginalCenter.y - 86
                            }, completion: nil)

                        
                })
                
                
              
                
            }
            else {
            //delete
            }
            

        }
        
        
//        print("location: \(location)")
//        print("translation: \(translation)")
    }


    @IBAction func tapScheduleView(sender: UITapGestureRecognizer) {
        scheduleView.alpha = 0
    }
}
