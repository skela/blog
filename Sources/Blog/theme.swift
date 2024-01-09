import Foundation
import Publish
import Plot

struct BlogThemeHTMLFactory<Site:Website> : HTMLFactory
{
	func makeIndexHTML(for index: Index,context: PublishingContext<Site>) throws -> HTML
	{
		HTML(
			.lang(context.site.language),
			.head(for: index, on: context.site),
			.body
			{
				SiteHeader(context: context, selectedSelectionID: nil)
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
				Wrapper
				{
					H1(section.title)
					ItemList(items: section.items, site: context.site)
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

private struct Wrapper : ComponentContainer
{
	@ComponentBuilder var content : ContentProvider

	var body : Component
	{
		Div(content: content).class("wrapper")
	}
}

private struct SiteHeader<Site: Website> : Component
{
	var context : PublishingContext<Site>
	var selectedSelectionID : Site.SectionID?

	var body : Component
	{
		Header
		{
			//Wrapper
//			{
				Span
				{
				Link(context.site.name, url: "/")
				.class("site-name")

				if Site.SectionID.allCases.count > 1
				{
					navigation
				}

				socials
				}
		//	}
		}
	}

	private var navigation : Component
	{
		Navigation
		{
			List(Site.SectionID.allCases)
			{ sectionID in
				let section = context.sections[sectionID]

				return Link(section.title,url: section.path.absoluteString)
				.class(sectionID == selectedSelectionID ? "selected" : "")
			}
		}
	}

	private var socials : Component
	{
		let html = """
<a href="https://twitter.com/skelimon" target="_blank" rel="noopener" title="Twitter"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentcolor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9.0 01-3.14 1.53 4.48 4.48.0 00-7.86 3v1A10.66 10.66.0 013 4s-4 9 5 13a11.64 11.64.0 01-7 2c9 5 20 0 20-11.5a4.5 4.5.0 00-.08-.83A7.72 7.72.0 0023 3z" /></svg></a>
<a href="https://github.com/skela" target="_blank" rel="noopener" title="Github"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentcolor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37.0 00-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44.0 0020 4.77 5.07 5.07.0 0019.91 1S18.73.65 16 2.48a13.38 13.38.0 00-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07.0 005 4.77 5.44 5.44.0 003.5 8.55c0 5.42 3.3 6.61 6.44 7A3.37 3.37.0 009 18.13V22" /></svg></a>
<a href="https://www.linkedin.com/in/alek-slater" target="_blank" rel="noopener" title="Linkedin"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentcolor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 016 6v7h-4v-7a2 2 0 00-2-2 2 2 0 00-2 2v7h-4v-7a6 6 0 016-6z" /><rect x="2" y="9" width="4" height="12" /><circle cx="4" cy="4" r="2" /></svg></a>
"""
		return Div(html:html).class("socials")
	}

}


private struct ItemList<Site:Website> : Component
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

private struct ItemTagList<Site:Website> : Component
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

private struct SiteFooter : Component
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

