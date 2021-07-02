//
//  Trophy.swift
//  TrophyKit
//
//  Created by Yubo Qin on 6/24/21.
//

import UIKit

/// Main class for `TrophyKit`.
public class Trophy {

    /// Static constants
    private static let horizontalPadding: CGFloat = 24.0
    private static let labelPadding: CGFloat = 16.0
    private static let bottomPadding: CGFloat = 64.0

    /// Retained `configuration` struct.
    private let configuration: TrophyConfiguration
    /// Flag to mark if the trophy is shown.
    private var isShown = false
    /// Store initial constraints so that we can deactive to make views restore to original state.
    private var initialConstraints: [NSLayoutConstraint] = []

    /// Subviews
    private lazy var iconView = UIImageView()
    private lazy var trophyView = UIImageView()
    private lazy var circleView = makeCircleView()
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    private lazy var labelView = makeLabelView()

    // MARK: - Initializer

    /// Initializes a `Trophy` instance to show the banner. You must call `show` function to show the
    /// animated banner in given views. The cost of initializer is very small if you do not call `show`.
    ///
    /// - Parameters:
    ///   - configuration: Custom configuration for the banner.
    public init(configuration: TrophyConfiguration = TrophyConfiguration()) {
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private helpers

    private func makeCircleView() -> UIView {
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: height, height: height))

        circleView.backgroundColor = .clear

        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: height, height: height)).cgPath
        circleLayer.fillColor = configuration.lightColor.cgColor
        circleView.layer.addSublayer(circleLayer)

        circleView.addSubview(iconView)
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit

        circleView.addSubview(trophyView)
        trophyView.tintColor = .white
        trophyView.contentMode = .scaleAspectFit
        trophyView.alpha = 0.0

        iconView.translatesAutoresizingMaskIntoConstraints = false
        trophyView.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: height),
            circleView.heightAnchor.constraint(equalToConstant: height),

            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 0.5),

            trophyView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            trophyView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            trophyView.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 0.5),
        ])

        return circleView
    }

    private func makeLabelView() -> UIView {
        let labelView = UIView()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = configuration.darkColor
        labelView.layer.cornerRadius = height / 2
        labelView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        labelView.clipsToBounds = true

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2.0

        titleLabel.numberOfLines = 1
        titleLabel.textColor = .white
        titleLabel.alpha = 0.9
        titleLabel.font = .systemFont(ofSize: fontSize)
        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = .white
        subtitleLabel.alpha = 0.9
        subtitleLabel.font = .systemFont(ofSize: fontSize)
        stackView.addArrangedSubview(subtitleLabel)

        labelView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: height / 2 + Self.labelPadding),
            stackView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -height / 2 - Self.labelPadding),

            labelView.heightAnchor.constraint(equalToConstant: height),
        ])

        return labelView
    }

    private var height: CGFloat {
        Self.getHeight(for: configuration.size)
    }

    private var fontSize: CGFloat {
        Self.getFontSize(for: configuration.size)
    }

    private static func getHeight(for size: TrophyConfiguration.TrophySize) -> CGFloat {
        switch size {
        case .small:
            #if os(iOS)
            return 48.0
            #else
            return 84.0
            #endif
        case .medium:
            #if os(iOS)
            return 56.0
            #else
            return 96.0
            #endif
        case .large:
            #if os(iOS)
            return 64.0
            #else
            return 108.0
            #endif
        }
    }

    private static func getFontSize(for size: TrophyConfiguration.TrophySize) -> CGFloat {
        switch size {
        case .small:
            #if os(iOS)
            return 14.0
            #else
            return 22.0
            #endif
        case .medium:
            #if os(iOS)
            return 16.0
            #else
            return 28.0
            #endif
        case .large:
            #if os(iOS)
            return 18.0
            #else
            return 34.0
            #endif
        }
    }

    private static func getDefaultImage(for size: TrophyConfiguration.TrophySize) -> UIImage {
        UIImage(systemName: "rosette",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: getHeight(for: size) / 2))!
    }

    private func makeOptionalImage(for symbol: String?) -> UIImage? {
        var iconImage: UIImage?
        if let symbol = symbol {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: Self.getHeight(for: configuration.size) / 2)
            iconImage = UIImage(systemName: symbol, withConfiguration: symbolConfiguration)
        }
        return iconImage
    }

    private func prepareForReuse() {
        /// Reset values
        titleLabel.text = nil
        subtitleLabel.text = nil
        subtitleLabel.isHidden = true

        /// Reset constraints in order to restore to state before being shown.
        NSLayoutConstraint.deactivate(initialConstraints)

        /// Reset parameters to restore to state before animations.
        labelView.alpha = 1.0
    }

    // MARK: - Public APIs

    /// Shows an animated trophy banner in a given view.
    ///
    /// Invoking this function multiple times on the same `Trophy` instance is efficient.
    /// Please note that currently both `title` and `subtitle` only support 1 line of text instead of
    /// wrapping. Please arrange texts properly.
    ///
    /// - Parameters:
    ///   - view: The view in which the animated trophy banner should be shown.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - icon: Image for icon that is shown in the ball. This icon is shown before the banner, usually
    ///           can be your logo instead of a trophy image.
    ///   - trophyIcon: Image for trophy icon that is shown on the left side of the banner. Usually can be
    ///                 a trophy or rosette.
    public func show(in view: UIView,
                     title: String,
                     subtitle: String? = nil,
                     icon: UIImage? = nil,
                     trophyIcon: UIImage? = nil) {
        /// Guard and set `isShown` flag.
        guard !isShown else {
            return
        }
        isShown = true

        /// Create container view.
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(labelView)
        container.addSubview(circleView)

        view.addSubview(container)

        /// Assign values.
        iconView.image = icon ?? Self.getDefaultImage(for: configuration.size)
        trophyView.image = trophyIcon ?? Self.getDefaultImage(for: configuration.size)
        titleLabel.text = title
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        }

        /// Apply new constraints.
        let widthConstraint = labelView.widthAnchor.constraint(equalToConstant: 0)
        let circleViewCenterXConstraint = circleView.centerXAnchor.constraint(equalTo: container.centerXAnchor)

        /// Total width is labelView.width plus radius of left circle (height / 2),
        /// therefore pad the leading side to make sure that the whole view is center aligned.
        let labelViewCenterXConstraint = labelView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: height / 4)

        initialConstraints = [
            circleViewCenterXConstraint,
            labelView.leadingAnchor.constraint(equalTo: circleView.centerXAnchor),
            widthConstraint,

            container.heightAnchor.constraint(equalToConstant: height),
            container.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: Self.horizontalPadding),
            container.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Self.horizontalPadding),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Self.bottomPadding),
        ]
        NSLayoutConstraint.activate(initialConstraints)

        /// Animation parameters
        let circleDuration = 0.35
        let circleShowTime = 0.5
        let bannerDuration = 0.25
        let bannerShowTime = 3.0

        /// Before animation parameters.
        circleView.transform = CGAffineTransform(scaleX: 0, y: 0)

        /// TODO: Refactory this silly animate chain. Somehow `UIViewPropertyAnimator` not working properly.
        UIView.animate(withDuration: circleDuration, delay: 0.0, options: .curveEaseInOut) {
            self.circleView.transform = .identity
        } completion: { _ in
            UIView.animate(withDuration: bannerDuration, delay: circleShowTime, options: .curveEaseInOut) {
                self.iconView.alpha = 0.0
                self.trophyView.alpha = 1.0

                widthConstraint.isActive = false
                circleViewCenterXConstraint.isActive = false
                labelViewCenterXConstraint.isActive = true

                view.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: bannerDuration, delay: bannerShowTime, options: .curveEaseInOut) {
                    self.iconView.alpha = 1.0
                    self.trophyView.alpha = 0.0

                    widthConstraint.isActive = true
                    circleViewCenterXConstraint.isActive = true
                    labelViewCenterXConstraint.isActive = false
                    self.labelView.alpha = 0.0

                    view.layoutIfNeeded()
                } completion: { _ in
                    UIView.animate(withDuration: circleDuration, delay: bannerDuration, options: .curveEaseInOut) {
                        self.circleView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    } completion: { finished in
                        /// Reset `isShown` flag when everything is done.
                        defer {
                            self.isShown = false
                        }
                        if finished {
                            container.removeFromSuperview()
                            self.prepareForReuse()
                        }
                    }
                }
            }
        }
    }

    /// Shows an animated trophy banner in a given view, with SF Symbol images.
    ///
    /// - Parameters:
    ///   - view: The view in which the animated trophy banner should be shown.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - iconSymbol: SF Symbol for icon image.
    ///   - trophyIconSymbol: SF Symbol for trophy image.
    public func show(in view: UIView,
                     title: String,
                     subtitle: String? = nil,
                     iconSymbol: String? = nil,
                     trophyIconSymbol: String? = nil) {
        show(in: view,
             title: title,
             subtitle: subtitle,
             icon: makeOptionalImage(for: iconSymbol),
             trophyIcon: makeOptionalImage(for: trophyIconSymbol))
    }

    /// Shows an animated trophy banner in a given view controller.
    ///
    /// - Parameters:
    ///   - viewController: `UIViewController` in which the banner is shown.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - icon: Image for icon that is shown in the ball. This icon is shown before the banner, usually
    ///           can be your logo instead of a trophy image.
    ///   - trophyIcon: Image for trophy icon that is shown on the left side of the banner. Usually can be
    ///                 a trophy or rosette.
    public func show(from viewController: UIViewController,
                     title: String,
                     subtitle: String? = nil,
                     icon: UIImage? = nil,
                     trophyIcon: UIImage? = nil) {
        show(in: viewController.view,
             title: title,
             subtitle: subtitle,
             icon: icon,
             trophyIcon: trophyIcon)
    }

    /// Shows an animated trophy banner in a given view controller, with SF Symbol images.
    /// - Parameters:
    ///   - viewController: `UIViewController` in which the banner is shown.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - iconSymbol: SF Symbol for icon image.
    ///   - trophyIconSymbol: SF Symbol for trophy image.
    public func show(from viewController: UIViewController,
                     title: String,
                     subtitle: String? = nil,
                     iconSymbol: String? = nil,
                     trophyIconSymbol: String? = nil) {
        show(from: viewController,
             title: title,
             subtitle: subtitle,
             icon: makeOptionalImage(for: iconSymbol),
             trophyIcon: makeOptionalImage(for: trophyIconSymbol))
    }

}
