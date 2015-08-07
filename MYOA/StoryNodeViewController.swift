//
//  StoryNodeViewController.swift
//  MYOA
//
//  Created by Jarrod Parkes on 11/2/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit

class StoryNodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var storyNode: StoryNode!
    
    @IBOutlet weak var adventureImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restartButton: UIButton!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set the image
        if let imageName = storyNode.imageName {
            self.adventureImageView.image = UIImage(named: imageName)
        }
        
        // Set the message text
        self.messageTextView.text = storyNode.message
        
        // Hide the restart button if there are choices to be made
        restartButton.hidden = storyNode.promptCount() > 0
    }
    
        // MARK: - Table - Place Holder Implementation
    
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            // This calls for the instantiation of the StoryNode View Controller to be populated based on user selection from UITableView cell activation and assigns the local variable storyController
            let storyController = self.storyboard!.instantiateViewControllerWithIdentifier("StoryNodeViewController") as!StoryNodeViewController
            
            /* Determines where along within the story in which to traverse based on user selection from execution of line # 62 when selected */
            storyController.storyNode = self.storyNode.storyNodeForIndex(indexPath.row)
            
            /* This 'pushes' the current story onto the Navigation controller, i.e., StoryNodeViewController onto the screen view for further UI correspondance */
            self.navigationController!.pushViewController(storyController, animated: true)
    
    }
    
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            /* Originally returned the number two however the following method call from within Struct object class called from StoryNode.swift will return the same parameter for the amount of selection choices that the storyline passes off to set promptForIndex method */
            return storyNode.promptCount()
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
    
            /* Assigns the two UIButton selectors for storyline to delve further into the storyline by calling back to line #43 to determine current storyNode was selected and then dequeues that segue and assigns the current index to the promptForIndex method call from StoryNode struct and setting the appropriate text that corresponds to each UIButton*/
            cell.textLabel!.text = storyNode.promptForIndex(indexPath.row)
            
            return cell
        }

    
    @IBAction func restartStory() {
        let controller = self.navigationController!.viewControllers[1] as! UIViewController
        self.navigationController?.popToViewController(controller, animated: true)
    }
    
}