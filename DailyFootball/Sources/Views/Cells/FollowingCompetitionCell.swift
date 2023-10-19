//
//  FollowingCompetitionCell.swift
//  DailyFootball
//
//  Created by walkerhilla on 2023/10/02.
//

import UIKit
import Kingfisher
import SnapKit

final class FollowingCompetitionCell: UITableViewCell {
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [deleteButton, logoImageView, titleLabel, reorderButton])
    view.axis = .horizontal
    view.alignment = .center
    view.spacing = 17
    view.distribution = .fillProportionally
    return view
  }()
  
  private lazy var deleteButton: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(systemName: "minus.circle.fill")
    view.contentMode = .scaleAspectFit
    view.tintColor = .red
    view.isHidden = true

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(tapGesture)
    return view
  }()
  
  private lazy var reorderButton: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(systemName: "line.3.horizontal")
    view.contentMode = .scaleAspectFit
    view.tintColor = .systemGray3
    view.isHidden  = true
    return view
  }()
  
  private lazy var logoImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.tintColor = .black
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 15, weight: .regular)
    view.numberOfLines = 1
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setDefaultConstraints()
    setCellUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var isEditingMode: Bool = false {
    didSet {
      updateAccessoryViewForEditing(isEditingMode)
    }
  }
  
  var deleteAction: (() -> ())?
  
  var containerFrame: CGRect {
    return containerView.frame
  }
  
  public func configureView(with competition: Competition) {
    setLogoImage(competition)
    setTitle(competition)
    
  }
  
  private func setCellUI() {
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  private func setLogoImage(_ data: Competition) {
    if let imageSource = URL(string: data.logoURL) {
      logoImageView.kf.setImage(with: imageSource)
    }
  }
  
  private func setTitle(_ data: Competition) {
    titleLabel.text = data.title
  }
  
  private func setDefaultConstraints() {
    contentView.addSubview(containerView)
    containerView.addSubview(stackView)
    
    containerView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(5)
      make.horizontalEdges.equalToSuperview().inset(14)
      make.bottom.equalToSuperview().offset(-5)
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    deleteButton.snp.makeConstraints { make in
      make.size.equalTo(23)
    }
    
    logoImageView.snp.makeConstraints { make in
      make.size.equalTo(28)
    }
    
    reorderButton.snp.makeConstraints { make in
      make.size.equalTo(25)
    }
  }
  
  private func updateAccessoryViewForEditing(_ isEditingMode: Bool) {
    deleteButton.isHidden = !isEditingMode
    reorderButton.isHidden = !isEditingMode
  }
  
  @objc private func deleteButtonTapped() {
    deleteAction?()
  }
}
