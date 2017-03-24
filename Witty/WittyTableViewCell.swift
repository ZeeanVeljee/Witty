//
//  WittyTableViewCell.swift
//  Witty
//
//  Created by Zeean Veljee on 17/04/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import UIKit
import Firebase

class WittyTableViewCell: UITableViewCell {
    
    var wit: Wit!
    var voteRef: FIRDatabaseReference!

    @IBOutlet weak var witText: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var voteImage: UIImageView!
    @IBOutlet weak var witView: UIView!
    
    @IBOutlet weak var wittyProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(WittyTableViewCell.voteTapped(_:)))
        voteImage.addGestureRecognizer(tap)
        voteImage.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func voteTapped(_ sender: UITapGestureRecognizer) {
        voteRef.observeSingleEvent(of: .value, with: { snapshot in
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.voteImage.image = UIImage(named: "Unvote")
                
                //self.wit.addSubtractVote(true)
                self.voteRef.setValue(true)
            }
            else {
                self.voteImage.image = UIImage(named: "Vote")
                //self.wit.addSubtractVote(false)
                self.voteRef.removeValue()
            }
        })
    }

}
