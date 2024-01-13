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
	var description = """
Welcome to Alek Slater's Tech Blog, where coding meets creativity and technology is the ultimate problem-solving tool!
As a fervent software developer, I'm on a journey through the ever-evolving landscape of technology,
exploring the realms of apps, linux, docker, smart homes and 3D printing to tackle and solve interesting problems.
"""
	var language : Language { .english }
	var imagePath : Path? { nil }
	var favicon : Favicon? { .init(path: Path("/favicon.svg"), type: "image/svg+xml")}
}

public extension Theme
{
	static var blog : Self
	{
		return Theme(
			htmlFactory: BlogHTMLFactory(),
			resourcePaths: ["Resources/styles.css"]
		)
	}
}

try Blog().publish(withTheme: .blog)
