{**
 * plugins/themes/rumahJurnal/templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Modern Article Summary Card for Rumah Jurnal Theme
 * Displays article metadata, authors, abstract preview, and galley action buttons.
 *}

{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$publication->getData('urlPath')|default:$article->getId()}

{if !$heading}
	{assign var="heading" value="h3"}
{/if}

{if (!$section.hideAuthor && $publication->getData('hideAuthor') == APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{assign var=articleUrl value=""}
{if $journal}
	{capture assign="articleUrl"}{url journal=$journal->getPath() page="article" op="view" path=$articlePath}{/capture}
{else}
	{capture assign="articleUrl"}{url page="article" op="view" path=$articlePath}{/capture}
{/if}

<div class="obj_article_summary bg-white rounded-2xl border border-slate-200/90 hover:border-primary/40 hover:shadow-xl transition-all duration-300 p-5 sm:p-6 group flex flex-col md:flex-row gap-5 items-start">
	{* Cover image if available *}
	{if $publication->getLocalizedData('coverImage')}
		{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
		<div class="w-full md:w-32 flex-shrink-0">
			<a href="{$articleUrl|escape}" class="block overflow-hidden rounded-xl border border-slate-200/80 shadow-sm aspect-[3/4] bg-slate-50">
				<img
					src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
					alt="{$coverImage.altText|escape|default:$publication->getLocalizedFullTitle()}"
					class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
					loading="lazy"
				>
			</a>
		</div>
	{/if}

	<div class="flex-1 min-w-0 w-full flex flex-col justify-between">
		<div>
			{* Metadata Badges Row *}
			<div class="flex flex-wrap items-center gap-2 mb-2.5">
				{* Journal Badge *}
				{if $journal}
					<a href="{url journal=$journal->getPath()}" 
					   class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-primary-50 text-primary hover:bg-primary hover:text-white transition duration-200">
						<i class="fa-solid fa-book-bookmark text-[11px] text-accent"></i>
						<span class="truncate max-w-[280px]">{$journal->getLocalizedName()|escape}</span>
					</a>
				{elseif $currentContext}
					<span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-primary-50 text-primary">
						<i class="fa-solid fa-book-bookmark text-[11px] text-accent"></i>
						<span class="truncate max-w-[280px]">{$currentContext->getLocalizedName()|escape}</span>
					</span>
				{/if}

				{* Publication Date *}
				{assign var=submissionDatePublished value=$publication->getData('datePublished')}
				{if $showDatePublished && $submissionDatePublished}
					<span class="inline-flex items-center gap-1.5 text-xs text-slate-500 font-medium px-2 py-0.5 rounded-md bg-slate-100/80">
						<i class="fa-regular fa-calendar text-slate-400"></i>
						<span>{$submissionDatePublished|date_format:$dateFormatShort}</span>
					</span>
				{/if}

				{* Pages *}
				{assign var=submissionPages value=$publication->getData('pages')}
				{if $submissionPages}
					<span class="inline-flex items-center gap-1.5 text-xs text-slate-500 font-medium px-2 py-0.5 rounded-md bg-slate-100/80">
						<i class="fa-regular fa-file-lines text-slate-400"></i>
						<span>Hal. {$submissionPages|escape}</span>
					</span>
				{/if}
			</div>

			{* Article Title *}
			<{$heading} class="text-base sm:text-lg font-bold text-slate-900 group-hover:text-primary transition-colors duration-200 leading-snug mb-2">
				<a id="article-{$article->getId()}" href="{$articleUrl|escape}" class="hover:underline">
					{$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}
				</a>
			</{$heading}>

			{* Authors *}
			{if $showAuthor}
				<div class="flex items-center gap-2 text-xs sm:text-sm text-slate-600 font-medium mb-3">
					<i class="fa-solid fa-user-pen text-slate-400 flex-shrink-0"></i>
					<span class="line-clamp-1">{$publication->getAuthorString($authorUserGroups)|escape}</span>
				</div>
			{/if}

			{* Abstract preview if available *}
			{assign var="abstractRaw" value=$publication->getLocalizedData('abstract')}
			{if $abstractRaw}
				{assign var="abstractClean" value=$abstractRaw|strip_tags|trim}
				{if $abstractClean}
					<div x-data="{ open: false }" class="mt-2 mb-3 bg-slate-50/70 rounded-xl p-3 border border-slate-100 text-xs sm:text-sm text-slate-600 leading-relaxed">
						<div :class="open ? '' : 'line-clamp-2'" class="transition-all">
							{$abstractClean|escape}
						</div>
						<button 
							type="button" 
							@click="open = !open" 
							class="mt-1.5 inline-flex items-center gap-1 text-xs font-bold text-primary hover:text-primary-800 transition">
							<span x-text="open ? '{translate key="plugins.themes.rumahJurnal.search.hideAbstract"}' : '{translate key="plugins.themes.rumahJurnal.search.showAbstract"}'">
								{translate key="plugins.themes.rumahJurnal.search.showAbstract"}
							</span>
							<i class="fa-solid text-[10px]" :class="open ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
						</button>
					</div>
				{/if}
			{/if}
		</div>

		{* Bottom Row: DOI & Action Buttons *}
		<div class="flex flex-wrap items-center justify-between gap-3 pt-3 border-t border-slate-100 mt-2">
			{* DOI Identifier *}
			<div>
				{assign var="doiVal" value=$publication->getDoi()|default:$publication->getStoredPubId('doi')}
				{if $doiVal}
					<a href="https://doi.org/{$doiVal|escape}" target="_blank" rel="noopener noreferrer" 
					   class="inline-flex items-center gap-1.5 text-xs text-slate-500 hover:text-primary bg-slate-100 hover:bg-slate-200/80 px-2.5 py-1 rounded-lg transition font-mono">
						<span class="font-bold text-[10px] text-accent bg-accent/15 px-1 rounded">DOI</span>
						<span class="truncate max-w-[200px] sm:max-w-xs">{$doiVal|escape}</span>
						<i class="fa-solid fa-arrow-up-right-from-square text-[10px] text-slate-400"></i>
					</a>
				{/if}
			</div>

			{* Action Galleys / View Article *}
			<div class="flex flex-wrap items-center gap-2 ml-auto">
				{* View Detail button *}
				<a href="{$articleUrl|escape}" 
				   class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-700 bg-slate-100 hover:bg-slate-200 transition duration-200">
					<span>{translate key="plugins.themes.rumahJurnal.search.viewArticle"}</span>
					<i class="fa-solid fa-chevron-right text-[10px]"></i>
				</a>

				{* Galleys / PDF Button *}
				{if !$hideGalleys && $publication->getData('galleys')}
					{foreach from=$publication->getData('galleys') item=galley}
						{assign var="galleyId" value=$galley->getBestGalleyId()}
						{assign var="galleyPath" value=$articlePath|to_array:$galleyId}
						{if $journal}
							{capture assign="galleyLink"}{url journal=$journal->getPath() page="article" op="view" path=$galleyPath}{/capture}
						{else}
							{capture assign="galleyLink"}{url page="article" op="view" path=$galleyPath}{/capture}
						{/if}
						<a href="{$galleyLink|escape}" 
						   class="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-xl text-xs font-bold text-white bg-primary hover:bg-primary-900 shadow-sm hover:shadow transition duration-200">
							<i class="fa-solid fa-file-pdf text-accent"></i>
							<span>{$galley->getGalleyLabel()|escape}</span>
						</a>
					{/foreach}
				{/if}
			</div>
		</div>
	</div>

	{call_hook name="Templates::Issue::Issue::Article"}
</div>
