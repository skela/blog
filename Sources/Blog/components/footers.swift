import Foundation
import Publish
import Plot

struct SiteFooter : Component
{
	var body : Component
	{
		Footer
		{
			Span
			{
				Text("Built with Swift using ")
				Link("Publish.", url: "https://github.com/johnsundell/publish")
				Text(" ")
				Link("RSS.", url: "/feed.rss")
			}
		}
	}
}
