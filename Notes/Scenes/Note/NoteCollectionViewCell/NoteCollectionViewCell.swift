//
//  NoteCollectionViewCell.swift
//  Notes
//
//  Created by elene malakmadze on 27.11.25.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    private let name = UILabel()
    private let content = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(name)
        addSubview(content)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 8
        let nameHeight: CGFloat = 20
        let spacing: CGFloat = 4
        
        name.frame = CGRect(
            x: padding,
            y: padding,
            width: contentView.bounds.width - (padding * 2),
            height: nameHeight
        )
        
        content.frame = CGRect(
            x: padding,
            y: name.frame.maxY + spacing,
            width: contentView.bounds.width - (padding * 2),
            height: contentView.bounds.height - name.frame.maxY - spacing - padding
        )
    }
    
    func configure(with note: Note) {
        name.text = note.name
        content.text = note.content
    }
}
