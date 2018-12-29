//
//  UserDetailTVCell.swift
//  SuryaAssignToMe
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailTVCell: UITableViewCell {

    let profileImageView2:UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "user"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shubham"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    let emaiLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImageView2)
        self.addSubview(emaiLabel)
        self.addSubview(nameLabel)
       
    
        profileImageView2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        profileImageView2.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView2.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant:20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView2.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        emaiLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        emaiLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        emaiLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        emaiLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValues(entity:data1){
        profileImageView2.sd_setImage(with: URL(string: entity.imageUrl ?? ""), placeholderImage: UIImage(named: "user"))
        nameLabel.text = "\(entity.firstName ?? "" ) \(entity.lastName ?? "" )"
        emaiLabel.text = entity.emailId
    }
    
}


