import Foundation
import Publish
import Plot

struct SiteHeader<Site:Website> : Component
{
	var context : PublishingContext<Site>
	var selectedSelectionID : Site.SectionID?

	var body : Component
	{
		Header
		{
			Span
			{
				Link(url: "/",label:{ logo }).class("header_logo_link")

				Span
				{
					if Site.SectionID.allCases.count > 1
					{
						navigation
					}
				}.class("header_right")
			}.class("header_inner")
		}.class("header")
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

	private var logo : Component
	{
			Div
			{
				Span
				{
					Text("alek@world.com")
				}.class("header_logo_terminal_prompt")

				Span
				{
					Text("> ls .")
				}.class("logo_ls_pwd")

//				Span
				//{
//					Text("> cd /")
//				}.class("logo_cd_root")

				Span
				{

				}.class("header_logo_terminal_cursor")
			}.class("header_logo_terminal")
	}
}

