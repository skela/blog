import Foundation
import Publish
import Plot

struct BlogHTMLFactory<Site:Website> : HTMLFactory
{
	func makeIndexHTML(for index: Index,context: PublishingContext<Site>) throws -> HTML
	{
		HTML(
			.lang(context.site.language),
			.head(for: index, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: nil)
				IndexPage(context:context,index:index)
				SiteFooter()
			}
		)
	}

	func makeSectionHTML(for section: Section<Site>,context: PublishingContext<Site>) throws -> HTML
	{
		HTML(
			.lang(context.site.language),
			.head(for: section, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: section.id)
				switch Blog.SectionID(rawValue:section.id.rawValue)
				{
				case .posts: PostsPage(context:context,section:section)
				case .about: AboutPage(context:context,section:section)
				case nil: NotFoundPage()
				}
				SiteFooter()
			}
		)
	}

	func makeItemHTML(for item: Item<Site>,context: PublishingContext<Site>) throws -> HTML
	{
		HTML(
			.lang(context.site.language),
			.head(for: item, on: context.site),
			.body(
				.class("item-page"),
				.components
				{
					SiteHeader(context: context, selectedSelectionID: item.sectionID)
					Wrapper
					{
						Article
						{
							Div(item.content.body).class("content")
							Span("Tagged with: ")
							ItemTagList(item: item, site: context.site)
						}
					}
					SiteFooter()
				}
			)
		)
	}

	func makePageHTML(for page: Page,context: PublishingContext<Site>) throws -> HTML
	{
		HTML(
			.lang(context.site.language),
			.head(for: page, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: nil)
				Wrapper(page.body)
				SiteFooter()
			}
		)
	}

	func makeTagListHTML(for page: TagListPage,context: PublishingContext<Site>) throws -> HTML?
	{
		HTML(
			.lang(context.site.language),
			.head(for: page, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: nil)
				Wrapper
				{
					H1("Browse all tags")
					List(page.tags.sorted())
					{ tag in
						ListItem
						{
							Link(tag.string,
								url: context.site.path(for: tag).absoluteString
							)
						}
						.class("tag")
					}
					.class("all-tags")
				}
				SiteFooter()
			}
		)
	}

	func makeTagDetailsHTML(for page: TagDetailsPage,context: PublishingContext<Site>) throws -> HTML?
	{
		HTML(
			.lang(context.site.language),
			.head(for: page, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: nil)
				Wrapper
				{
					H1
					{
						Text("Tagged with ")
						Span(page.tag.string).class("tag")
					}

					Link("Browse all tags",
						url: context.site.tagListPath.absoluteString
					)
					.class("browse-all")

					ItemList(
						items: context.items(
							taggedWith: page.tag,
							sortedBy: \.date,
							order: .descending
						),
						site: context.site
					)
				}
				SiteFooter()
			}
		)
	}
}

