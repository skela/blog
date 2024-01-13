import Foundation
import Publish
import Plot

struct PostsPage<Site:Website>  : Component
{
	let context : PublishingContext<Site>
	let section : Section<Site>

	var body : Component
	{
		Wrapper
		{
			H1(section.title)
			ItemList(items: section.items, site: context.site)
		}
	}
}
