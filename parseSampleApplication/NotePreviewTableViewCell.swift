//
//  NotePreviewTableViewCell.swift
//  parseSampleApplication
//
//  Created by Alexander Karpov on 05.02.16.
//  Copyright © 2016 Alex Karpov. All rights reserved.
//

import UIKit

class NotePreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
