import Foundation
import Publish
import Plot

struct Blog : Website
{
	enum SectionID : String, WebsiteSectionID
	{
		case posts
		case about
	}

	struct ItemMetadata : WebsiteItemMetadata
	{
	}

	var url = URL(string: "https://alekslater.com")!
	var name = "Alek Slater"
	var description = "Hi, my name is Alek Slater. I made this blog to help me remember the things I have done and learned, so my future-self does not have to re-learn them in the future."
	var language : Language { .english }
	var imagePath : Path? { nil }
	var favicon : Favicon? { .init(path: Path("/favicon.svg"), type: "image/svg+xml")}
}

public extension Theme
{
	static var blog : Self
	{
		return Theme(
			htmlFactory: BlogThemeHTMLFactory(),
			resourcePaths: ["Resources/styles.css"]
		)
	}
}

try Blog().publish(withTheme: .blog)
