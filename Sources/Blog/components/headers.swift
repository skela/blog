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
				.id("header_nav_\(sectionID)")

			}
		}
	}

	private var logo : Component
	{
		Div
		{
			Span
			{
				Text("alek@world")
			}.class("header_logo_terminal_userhost")

			Span
			{
				Span { Text("") }.class("header_logo_terminal_powerline_left")
				Span { Text("~") }.class("header_logo_terminal_powerline_center")
				Span { Text("") }.class("header_logo_terminal_powerline_right")
			}.class("header_logo_terminal_powerline")

			Span
			{
				Text("ls .")
			}.class("logo_ls_pwd").id("header_nav_terminal_cmd")

			Span
			{
				Text("cd /")
			}.class("logo_cd_root")

			Span
			{

			}.class("header_logo_terminal_cursor")
		}.class("header_logo_terminal")
	}
}

