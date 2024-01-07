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
	var description = "A description of Blog"
	var language : Language { .english }
	var imagePath : Path? { nil }
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
