//
//  StudyingViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class StudyingViewController: UIViewController {
    // MARK: UI
    
    private lazy var titleProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .red
        progressView.progressTintColor = .blue
        return progressView
    }()
    
    // MARK: Properties
    
    private let cards: [FlashCard]
    
    private var cardsViews: [FlashCardView] = []
    
    private var cardsDeleted: Int {
        cards.count - cardsViews.count
    }
    
    private lazy var halfPoint: CGFloat = view.frame.width / .halfDivider
    
    /* (view.frame.width / 2) - делим экран на 2 части; (.pi / 6) - максимальный угол наклона будет 30 градусов;
    Если мы разделим центр карточки на это число, то получим нужный угол наклона */
    private lazy var dividerForAngle: CGFloat = (view.frame.width / .halfDivider) / (.pi / 6)
    
    private lazy var cardCenter: CGPoint = .zero
    
    // MARK: Init
    
    init(cards: [FlashCard]) {
        self.cards = cards
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCenterPoint()
    }
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = .white
        
        cards.forEach { element in
            cardsViews.append(FlashCardView(card: element))
        }
        cardsViews.last?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCard(_:))))
        
        titleProgressLabel.text = "0 / \(cards.count)"
    }
    
    private func setupCenterPoint() {
        guard let cardView = cardsViews.last else { return }
        cardCenter = cardView.center
    }
    
    private func setupLayout() {
        view.addSubview(titleProgressLabel)
        titleProgressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.topInset)
        }
        
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.top.equalTo(titleProgressLabel.snp.bottom).offset(Constants.topOffset)
        }
        
        for element in cardsViews {
            view.addSubview(element)
            element.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
                make.bottom.equalToSuperview().inset(Constants.bottomInset)
                make.top.equalTo(progressBar).inset(Constants.topInset)
            }
        }
    }
    
    @objc private func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? FlashCardView else { return }
        
        if sender.state == .ended {
            if card.center.x < .pointsFromSide || card.center.x > (view.frame.width - .pointsFromSide) {
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(
                        x: card.center.x < .pointsFromSide ? card.center.x - .spacer : card.center.x + .spacer,
                        y: card.center.y
                    )
                    card.alpha = .zero
                } completion: { _ in
                    self.cardsViews.removeLast().removeFromSuperview()
                    self.cardsViews.last?.addGestureRecognizer(UIPanGestureRecognizer(
                        target: self,
                        action: #selector(self.panCard(_:)))
                    )
                    self.nextStep()
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.cardCenter
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
    
    private func nextStep() {
        progressBar.setProgress(Float(cardsDeleted) / Float(cards.count), animated: true)
        titleProgressLabel.text = "\(cardsDeleted) / \(cards.count)"
    }
}

// MARK: - Constants

private extension StudyingViewController {
    enum Constants {
        static let sideInset = 20
        static let topInset = 20
        static let bottomInset = 50
        
        static let topOffset = 20
    }
}

private extension CGFloat {
    static let spacer: CGFloat = 200
    
    static let halfDivider: CGFloat = 2
    
    static let pointsFromCenter: CGFloat = 60
    
    static let pointsFromSide: CGFloat = 75
}
