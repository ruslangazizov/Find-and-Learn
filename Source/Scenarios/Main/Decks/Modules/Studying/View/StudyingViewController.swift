//
//  StudyingViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class StudyingViewController: UIViewController {
    // MARK: UI
    
    private lazy var cardView = FlashCardView(card: .init(frontSide: "Lorem Ipsum - это текст-\"рыба\", часто используемый в печати и", backSide: "Not some"))
    
    // MARK: Properties
    
    private lazy var halfPoint: CGFloat = view.frame.width / .halfDivider
    
    /* (view.frame.width / 2) - делим экран на 2 части; (.pi / 6) - максимальный угол наклона будет 30 градусов;
    Если мы разделим центр карточки на это число, то получим нужный угол наклона */
    private lazy var dividerForAngle: CGFloat = (view.frame.width / .halfDivider) / (.pi / 6)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupLayout()
    }
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = .white
        
        cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCard(_:))))
    }
    
    private func setupLayout() {
        view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(50)
        }
    }
    
    @objc private func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? FlashCardView else { return }
        
        if sender.state == .ended {
            if card.center.x < .pointsFromSide || card.center.x > (view.frame.width - .pointsFromSide) {
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(
                        x: card.center.x < .pointsFromSide ? card.center.x - 200 : card.center.x + 200,
                        y: card.center.y
                    )
                    card.alpha = .zero
                } completion: { _ in
                    card.removeFromSuperview()
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                card.messageAlpha = .zero
                card.transform = CGAffineTransform.identity
            }
            return
        }
        
        let point = sender.translation(in: view)
        card.center = CGPoint(
            x: view.center.x + point.x,
            y: view.center.y + point.y
        )
        
        if point.x <= .zero {
            card.showStudyMoreView()
        } else {
            card.showLearnedView()
        }
        card.messageAlpha = abs(point.x / view.center.x)
        let scale = min(.pointsFromCenter / abs(point.x), 1)
        card.transform = CGAffineTransform(rotationAngle: point.x / dividerForAngle).scaledBy(x: scale, y: scale)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let halfDivider: CGFloat = 2
    
    static let pointsFromCenter: CGFloat = 60
    
    static let pointsFromSide: CGFloat = 75
}
