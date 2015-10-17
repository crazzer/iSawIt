//
//  ShowTableViewCell.swift
//  iSawIt3
//
//  Created by craz on 11.10.15.
//  Copyright © 2015 craz. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var banner: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
