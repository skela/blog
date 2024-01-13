import Foundation
import Publish
import Plot

struct ItemList<Site:Website> : Component
{
	var items : [Item<Site>]
	var site : Site

	var body: Component
	{
		List(items)
		{ item in
			Article
			{
				H1(Link(item.title, url: item.path.absoluteString))
				ItemTagList(item: item, site: site)
				Paragraph(item.description)
			}
		}
		.class("item-list")
	}
}

struct ItemTagList<Site:Website> : Component
{
	var item : Item<Site>
	var site : Site

	var body: Component
	{
		List(item.tags)
		{ tag in
			Link(tag.string, url: site.path(for: tag).absoluteString)
		}
		.class("tag-list")
	}
}

