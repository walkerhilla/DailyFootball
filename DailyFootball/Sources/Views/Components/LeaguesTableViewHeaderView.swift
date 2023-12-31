//
//  LeaguesTableViewHeaderView.swift
//  DailyFootball
//
//  Created by walkerhilla on 2023/10/10.
//

import UIKit
import SnapKit

final class LeaguesTableViewHeaderView: UITableViewHeaderFooterView {
  
  enum EditButtonState {
    case done
    case editing
  }
  
  private lazy var containerView: UIView = {
    let view = UIView()
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.textColor = .label
    view.font = .systemFont(ofSize: 18, weight: .bold)
    return view
  }()
  
  private lazy var editButton: StatefulButton = {
    var config = UIButton.Configuration.plain()
    config.contentInsets = .zero
    let view = StatefulButton<EditButtonState>(config: config)
    
    var doneAttrString = AttributedString.init(LocalizedStrings.TabBar.Leagues.doneButton.localizedValue)
    doneAttrString.font = .systemFont(ofSize: 17, weight: .regular)
    
    var editingAttrString = AttributedString.init(LocalizedStrings.TabBar.Leagues.editingButton.localizedValue)
    editingAttrString.font = .systemFont(ofSize: 17, weight: .regular)
    
    view.setAttributedTitleWithColor(doneAttrString, UIColor.appColor(for: .accentColor), forState: .done)
    view.setAttributedTitleWithColor(editingAttrString, UIColor.appColor(for: .accentColor), forState: .editing)
    view.currentState = .done
    
    view.isHidden = true
    view.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    return view
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    contentView.backgroundColor = UIColor.appColor(for: .subBackground)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    setEditButton()
  }
  
  weak var delegate: TableViewEditableDelegate?
  
  private func setConstraints() {
    contentView.addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(editButton)
    
    containerView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview().priority(999)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.centerY.equalToSuperview()
    }
    
    editButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-20)
      make.centerY.equalToSuperview()
    }
  }
  
  func setHeaderTitle(title: String) {
    self.titleLabel.text = title
  }
  
  func showEditButton(_ show: Bool) {
    editButton.isHidden = !show
  }
  
  func setVisibility(isHidden: Bool) {
    self.contentView.subviews.forEach {
      $0.isHidden = isHidden
    }
  }
  
  func setEditButton() {
    guard let isEdit = delegate?.isEditMode() else { return }
    editButton.currentState = isEdit ? .editing : .done
  }
  
  @objc private func editButtonTapped() {
    delegate?.didTapEditButton()
    setEditButton()
  }
}
