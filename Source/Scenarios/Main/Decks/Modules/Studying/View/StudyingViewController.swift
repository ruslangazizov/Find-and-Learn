//
//  StudyingViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import UIKit

final class StudyingViewController: UIViewController {
    // MARK: UI
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .close)
        button.tintColor = .black
        return button
    }()
    
    private lazy var titleProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = .systemGreen
        return progressView
    }()
    
    private lazy var finishView = FinishStudyingView()
    
    // MARK: Dependencies
    
    private let presenter: StudyingViewOutput
    
    // MARK: Properties
    
    var cards: [FlashCard] = []
    
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
    
    init(presenter: StudyingViewOutput) {
        self.presenter = presenter
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
        
        navigationController?.isNavigationBarHidden = true
        setupCenterPoint()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Private
    
    private func configure() {
        view.backgroundColor = .white
        
        cards.forEach { element in
            cardsViews.append(FlashCardView(card: element))
        }
        cardsViews.last?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCard(_:))))
        
        titleProgressLabel.text = "0 / \(cards.count)"
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        finishView.restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        finishView.continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
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
        
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalTo(titleProgressLabel)
        }
        
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.top.equalTo(titleProgressLabel.snp.bottom).offset(Constants.topOffset)
        }
        
        view.addSubview(finishView)
        finishView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
            make.top.equalTo(progressBar).inset(Constants.topInset)
        }
        
        addCardsViews()
    }
    
    private func addCardsViews() {
        for element in cardsViews {
            view.addSubview(element)
            element.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
                make.bottom.equalToSuperview().inset(Constants.bottomInset)
                make.top.equalTo(progressBar).inset(Constants.topInset)
            }
        }
    }
    
    @objc private func exitButtonTapped(_ sender: UIButton) {
        showAskAlert(message: R.string.localizable.studying_screen_exit_message()) { _ in
            self.presenter.endStudying()
        }
    }
    
    @objc private func restartButtonTapped(_ sender: UIButton) {
        presenter.restart()
        cards.shuffle()
        start()
    }
    
    @objc private func continueButtonTapped(_ sender: UIButton) {
        presenter.continueLearning()
    }
    
    private func start() {
        progressBar.setProgress(0, animated: true)
        titleProgressLabel.text = "0 / \(cards.count)"
        
        cards.forEach { element in
            cardsViews.append(FlashCardView(card: element))
        }
        cardsViews.last?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCard(_:))))
        
        addCardsViews()
        finishView.userHasMistakes = false
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
                    self.presenter.actionWithCard(
                        card: card.card,
                        action: card.center.x < .pointsFromSide ? .studyMore : .learned
                    )
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

// MARK: - ViewInput

extension StudyingViewController: StudyingViewInput {
    func showHasMistakesFinish() {
        finishView.userHasMistakes = true
    }
    
    func continueLearning(cards: [FlashCard]) {
        self.cards = cards
        start()
    }
}

// MARK: - Constants

private extension StudyingViewController {
    enum Constants {
        static let sideInset = 20
        static let topInset = 20
        static let bottomInset = 20
        
        static let topOffset = 20
    }
}

private extension CGFloat {
    static let spacer: CGFloat = 200
    
    static let halfDivider: CGFloat = 2
    
    static let pointsFromCenter: CGFloat = 60
    
    static let pointsFromSide: CGFloat = 75
}
