test:
	xcodebuild test -scheme A-Commerce -workspace A-Commerce.xcworkspace -destination 'platform=iOS Simulator,name=iPhone 11,OS=14.5' | xcpretty && exit ${PIPESTATUS[0]}