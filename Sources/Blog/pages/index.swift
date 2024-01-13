import Foundation
import Publish
import Plot

struct IndexPage<Site:Website>  : Component
{
	let context : PublishingContext<Site>
	let index : Index

	var body : Component
	{
		Wrapper
		{
			H1(index.title)
			Paragraph(context.site.description)
				.class("description")

			H2("Latest content")
			ItemList(
				items: context.allItems(
					sortedBy: \.date,
					order: .descending
				),
				site: context.site
			)
		}
	}
}
