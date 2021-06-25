//
//  Trophy.swift
//  TrophyKit
//
//  Created by Yubo Qin on 6/24/21.
//

import UIKit

/// Main class for `TrophyKit`.
public class Trophy {

    /// Enum for sizes of a trophy banner.
    public enum TrophySize {
        case small
        case medium
        case large
    }
    
    public static let defaultLightColor = UIColor(red: 75/255, green: 180/255, blue: 27/255, alpha: 1.0)
    public static let defaultDarkColor = UIColor(red: 15/255, green: 114/255, blue: 15/255, alpha: 1.0)

    private static let horizontalPadding: CGFloat = 24.0
    private static let labelPadding: CGFloat = 16.0
    private static let bottomPadding: CGFloat = 64.0

    private let icon: UIImage
    private let trophyIcon: UIImage
    private let title: String
    private let subtitle: String?
    private let lightColor: UIColor
    private let darkColor: UIColor
    private let size: TrophySize

    private lazy var iconView = UIImageView()
    private lazy var trophyView = UIImageView()
    private lazy var circleView = makeCircleView()
    private lazy var labelView = makeLabelView()

    // MARK: - Initializer

    /// Initializes a `Trophy` instance to show the banner. You must call `show` function to show the
    /// animated banner in given views. The cost if initializer is very small if you do not call `show`.
    ///
    /// Please note that currently both `title` and `subtitle` only support 1 line of text instead of
    /// wrapping. Please arrange texts properly.
    ///
    /// - Parameters:
    ///   - icon: Image for icon that is shown in the ball. This icon is shown before the banner, usually
    ///           can be your logo instead of a trophy image.
    ///   - trophyIcon: Image for trophy icon that is shown on the left side of the banner. Usually can be
    ///                 a trophy or rosette.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - lightColor: The color of the ball.
    ///   - darkColor: The color of the banner.
    ///   - size: Size of the trophy banner.
    public init(icon: UIImage? = nil,
                trophyIcon: UIImage? = nil,
                title: String,
                subtitle: String? = nil,
                lightColor: UIColor = Trophy.defaultLightColor,
                darkColor: UIColor = Trophy.defaultDarkColor,
                size: TrophySize = .medium) {
        self.icon = icon ?? Self.getDefaultImage(for: size)
        self.trophyIcon = trophyIcon ?? icon ?? Self.getDefaultImage(for: size)
        self.title = title
        self.subtitle = subtitle
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.size = size
    }

    /// Initializes a `Trophy` instance to show the banner, with SF Symbols.
    ///
    /// Please see comments of the designated initializer for detailed information.
    ///
    /// - Parameters:
    ///   - iconSymbol: SF Symbol name for the icon image.
    ///   - trophyIconSymbol: SF Symbol name for the trophy image.
    ///   - title: Title text for banner.
    ///   - subtitle: Subtitle text for banner.
    ///   - lightColor: The color of the ball.
    ///   - darkColor: The color of the banner.
    ///   - size: Size of the trophy banner.
    public convenience init(iconSymbol: String? = nil,
                            trophyIconSymbol: String? = nil,
                            title: String,
                            subtitle: String? = nil,
                            lightColor: UIColor = Trophy.defaultLightColor,
                            darkColor: UIColor = Trophy.defaultDarkColor,
                            size: TrophySize = .medium) {
        func makeOptionalImage(for symbol: String?) -> UIImage? {
            var iconImage: UIImage?
            if let symbol = symbol {
                let configuration = UIImage.SymbolConfiguration(pointSize: Self.getHeight(for: size) / 2)
                iconImage = UIImage(systemName: symbol, withConfiguration: configuration)
            }
            return iconImage
        }

        self.init(icon: makeOptionalImage(for: iconSymbol),
                  trophyIcon: makeOptionalImage(for: trophyIconSymbol),
                  title: title,
                  subtitle: subtitle,
                  lightColor: lightColor,
                  darkColor: darkColor,
                  size: size)
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
        circleLayer.fillColor = lightColor.cgColor
        circleView.layer.addSublayer(circleLayer)

        circleView.addSubview(iconView)
        iconView.image = icon
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit

        circleView.addSubview(trophyView)
        trophyView.image = trophyIcon
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
        labelView.backgroundColor = darkColor
        labelView.layer.cornerRadius = height / 2
        labelView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        labelView.clipsToBounds = true

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2.0

        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.alpha = 0.9
        titleLabel.font = .systemFont(ofSize: fontSize)
        stackView.addArrangedSubview(titleLabel)

        if let subtitle = subtitle {
            let subtitleLabel = UILabel()
            subtitleLabel.numberOfLines = 1
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = .white
            subtitleLabel.alpha = 0.9
            subtitleLabel.font = .systemFont(ofSize: fontSize)
            stackView.addArrangedSubview(subtitleLabel)
        }

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
        Self.getHeight(for: size)
    }

    private var fontSize: CGFloat {
        Self.getFontSize(for: size)
    }

    private static func getHeight(for size: TrophySize) -> CGFloat {
        switch size {
        case .small:
            return 48.0
        case .medium:
            return 56.0
        case .large:
            return 64.0
        }
    }

    private static func getFontSize(for size: TrophySize) -> CGFloat {
        switch size {
        case .small:
            return 14.0
        case .medium:
            return 16.0
        case .large:
            return 18.0
        }
    }

    private static func getDefaultImage(for size: TrophySize) -> UIImage {
        UIImage(systemName: "rosette",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: getHeight(for: size) / 2))!
    }

    // MARK: - Public APIs

    /// Shows an animated trophy banner in a given view.
    ///
    /// - Parameters:
    ///     - view: The view in which the animated trophy banner should be shown.
    public func show(in view: UIView) {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(labelView)
        container.addSubview(circleView)

        view.addSubview(container)

        let widthConstraint = labelView.widthAnchor.constraint(equalToConstant: 0)
        let circleViewCenterXConstraint = circleView.centerXAnchor.constraint(equalTo: container.centerXAnchor)

        /// Total width is labelView.width plus radius of left circle (height / 2),
        /// therefore pad the leading side to make sure that the whole view is center aligned.
        let labelViewCenterXConstraint = labelView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: height / 4)

        NSLayoutConstraint.activate([
            circleViewCenterXConstraint,
            labelView.leadingAnchor.constraint(equalTo: circleView.centerXAnchor),
            widthConstraint,

            container.heightAnchor.constraint(equalToConstant: height),
            container.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: Self.horizontalPadding),
            container.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Self.horizontalPadding),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Self.bottomPadding),
        ])

        circleView.transform = CGAffineTransform(scaleX: 0, y: 0)

        /// Animation parameters
        let circleDuration = 0.35
        let circleShowTime = 0.5
        let bannerDuration = 0.25
        let bannerShowTime = 3.0

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
                        if finished {
                            container.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }

    /// Shows an animated trophy banner in a given view controller.
    ///
    /// - Parameters:
    ///     - viewController: `UIViewController` in which the banner is shown.
    public func show(from viewController: UIViewController) {
        show(in: viewController.view)
    }

}
