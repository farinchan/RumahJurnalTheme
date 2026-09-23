{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Modern Scientific Search Page for Rumah Jurnal Theme
 * Compatible with OJS 3.5 multi-journal and single-journal search workflows.
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

{assign var="hasActiveFilters" value=false}
{if $authors || $searchJournal || $dateFromYear || $dateToYear || $dateFrom || $dateTo}
	{assign var="hasActiveFilters" value=true}
{/if}

{assign var="hasSearchParam" value=false}
{if ($query && $query|trim != "") || ($authors && $authors|trim != "") || $searchJournal || $dateFromYear || $dateToYear}
	{assign var="hasSearchParam" value=true}
{/if}

{assign var="currentYear" value=$smarty.now|date_format:"%Y"|intval}
{assign var="startYearNum" value=$yearStart|default:2015|intval}
{assign var="endYearNum" value=$yearEnd|default:$currentYear|intval}
{if $startYearNum > $endYearNum}
	{assign var="startYearNum" value=$endYearNum-10}
{/if}

<main class="flex-grow bg-slate-50/70 py-8 sm:py-12" id="main-content" x-data="{ showFilters: {if $hasActiveFilters}true{else}false{/if} }">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

		{* Breadcrumb Navigation *}
		<nav class="flex items-center gap-2 text-xs text-slate-500 mb-6">
			<a href="{url page="index"}" class="hover:text-primary transition flex items-center gap-1.5">
				<i class="fa-solid fa-house text-slate-400"></i>
				<span>{translate key="navigation.home"}</span>
			</a>
			<i class="fa-solid fa-chevron-right text-[10px] text-slate-300"></i>
			<span class="text-slate-800 font-semibold">{translate key="common.search"}</span>
		</nav>

		{* Search Hero Card *}
		<div class="bg-white rounded-3xl border border-slate-200/90 shadow-sm p-6 sm:p-10 mb-8 relative overflow-hidden">
			{* Decorative background shapes *}
			<div class="absolute -right-16 -top-16 w-64 h-64 rounded-full bg-primary/5 pointer-events-none blur-3xl"></div>
			<div class="absolute -left-16 -bottom-16 w-64 h-64 rounded-full bg-accent/10 pointer-events-none blur-3xl"></div>

			<div class="relative z-10">
				{* Header Title *}
				<div class="max-w-3xl mb-8">
					<h1 class="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-slate-900 tracking-tight leading-tight">
						{translate key="plugins.themes.rumahJurnal.search.title"}
					</h1>
					<p class="text-sm sm:text-base text-slate-600 mt-2 leading-relaxed">
						{translate key="plugins.themes.rumahJurnal.search.subtitle"}
					</p>
				</div>

				{* Search Form Form Action Setup *}
				{capture name="searchFormUrl"}{url escape=false}{/capture}
				{assign var=formUrlParameters value=[]}
				{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|default:""|parse_str:$formUrlParameters}

				<form method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}" role="search" id="portalSearchForm">
					{foreach from=$formUrlParameters key=paramKey item=paramValue}
						<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
					{/foreach}

					{* Main Big Search Bar *}
					<div class="relative flex flex-col sm:flex-row items-stretch gap-3">
						<div class="relative flex-1">
							<div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-slate-400">
								<i class="fa-solid fa-magnifying-glass text-base sm:text-lg"></i>
							</div>
							<input 
								type="text" 
								id="query" 
								name="query" 
								value="{$query|escape}" 
								placeholder="{translate key="plugins.themes.rumahJurnal.search.inputPlaceholder"}" 
								class="w-full pl-12 pr-12 py-3.5 sm:py-4 rounded-2xl border-2 border-slate-200 text-slate-900 text-sm sm:text-base placeholder-slate-400 bg-white focus:outline-none focus:border-primary focus:ring-4 focus:ring-primary/10 transition shadow-sm"
								autocomplete="off">
							{if $query}
								<a href="{url page="search"}" 
								   title="Hapus pencarian" 
								   class="absolute inset-y-0 right-0 pr-4 flex items-center text-slate-400 hover:text-slate-600 transition">
									<i class="fa-solid fa-circle-xmark text-lg"></i>
								</a>
							{/if}
						</div>

						<div class="flex items-center gap-2">
							{* Advanced Filter Toggle Button *}
							<button 
								type="button" 
								@click="showFilters = !showFilters" 
								class="h-full px-4 py-3.5 sm:py-4 rounded-2xl border border-slate-200 bg-slate-50 hover:bg-slate-100 text-slate-700 text-sm font-semibold inline-flex items-center gap-2 transition focus:outline-none focus:ring-2 focus:ring-primary/20"
								:class="showFilters ? 'bg-primary-50 border-primary/40 text-primary' : ''">
								<i class="fa-solid fa-sliders text-sm" :class="showFilters ? 'text-primary' : 'text-slate-500'"></i>
								<span class="hidden md:inline">{translate key="plugins.themes.rumahJurnal.search.toggleFilters"}</span>
								<i class="fa-solid text-xs" :class="showFilters ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
							</button>

							{* Submit Button *}
							<button 
								type="submit" 
								class="flex-1 sm:flex-initial h-full px-7 py-3.5 sm:py-4 rounded-2xl bg-primary hover:bg-primary-900 text-white font-bold text-sm sm:text-base shadow-md hover:shadow-lg transition duration-200 inline-flex items-center justify-center gap-2.5">
								<i class="fa-solid fa-magnifying-glass text-accent"></i>
								<span>{translate key="common.search"}</span>
							</button>
						</div>
					</div>

					{* Expandable Advanced Filter Drawer *}
					<div 
						x-show="showFilters" 
						x-transition:enter="transition ease-out duration-200" 
						x-transition:enter-start="opacity-0 -translate-y-2" 
						x-transition:enter-end="opacity-100 translate-y-0" 
						x-transition:leave="transition ease-in duration-150" 
						x-transition:leave-start="opacity-100 translate-y-0" 
						x-transition:leave-end="opacity-0 -translate-y-2" 
						class="mt-6 pt-6 border-t border-slate-100 grid grid-cols-1 md:grid-cols-3 gap-5">

						{* Filter 1: Journal Selection (if multi-journal portal) *}
						<div>
							<label for="searchJournal" class="block text-xs font-bold uppercase tracking-wider text-slate-700 mb-2 flex items-center gap-1.5">
								<i class="fa-solid fa-book-bookmark text-accent"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.filterByJournal"}</span>
							</label>
							<div class="relative">
								<select 
									name="searchJournal" 
									id="searchJournal" 
									class="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-xs sm:text-sm bg-slate-50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition appearance-none">
									<option value="">{translate key="plugins.themes.rumahJurnal.search.allJournals"}</option>
									{if $searchableContexts}
										{foreach from=$searchableContexts item="searchableContext"}
											<option value="{$searchableContext->id}" {if $searchJournal == $searchableContext->id}selected{/if}>
												{$searchableContext->name|escape}
											</option>
										{/foreach}
									{/if}
								</select>
								<div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-chevron-down text-xs"></i>
								</div>
							</div>
						</div>

						{* Filter 2: Author Name *}
						<div>
							<label for="authors" class="block text-xs font-bold uppercase tracking-wider text-slate-700 mb-2 flex items-center gap-1.5">
								<i class="fa-solid fa-user-pen text-accent"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.filterByAuthor"}</span>
							</label>
							<div class="relative">
								<input 
									type="text" 
									id="authors" 
									name="authors" 
									value="{$authors|escape}" 
									placeholder="{translate key="plugins.themes.rumahJurnal.search.authorPlaceholder"}" 
									class="w-full px-3.5 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-xs sm:text-sm placeholder-slate-400 bg-slate-50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition">
							</div>
						</div>

						{* Filter 3: Publication Year Range *}
						<div>
							<label class="block text-xs font-bold uppercase tracking-wider text-slate-700 mb-2 flex items-center gap-1.5">
								<i class="fa-regular fa-calendar-days text-accent"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.dateRange"}</span>
							</label>
							<div class="grid grid-cols-2 gap-2">
								{* From Year *}
								<div class="relative">
									<select 
										name="dateFromYear" 
										id="dateFromYear" 
										class="w-full px-3 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-xs sm:text-sm bg-slate-50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition appearance-none">
										<option value="">{translate key="plugins.themes.rumahJurnal.search.yearFrom"}</option>
										{for $yr=$endYearNum to $startYearNum step -1}
											<option value="{$yr}" {if $dateFromYear == $yr}selected{/if}>{$yr}</option>
										{/for}
									</select>
									<div class="absolute inset-y-0 right-0 pr-2.5 flex items-center pointer-events-none text-slate-400">
										<i class="fa-solid fa-chevron-down text-[10px]"></i>
									</div>
								</div>

								{* To Year *}
								<div class="relative">
									<select 
										name="dateToYear" 
										id="dateToYear" 
										class="w-full px-3 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-xs sm:text-sm bg-slate-50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition appearance-none">
										<option value="">{translate key="plugins.themes.rumahJurnal.search.yearTo"}</option>
										{for $yr=$endYearNum to $startYearNum step -1}
											<option value="{$yr}" {if $dateToYear == $yr}selected{/if}>{$yr}</option>
										{/for}
									</select>
									<div class="absolute inset-y-0 right-0 pr-2.5 flex items-center pointer-events-none text-slate-400">
										<i class="fa-solid fa-chevron-down text-[10px]"></i>
									</div>
								</div>
							</div>
						</div>

						{call_hook name="Templates::Search::SearchResults::AdditionalFilters"}

						{* Reset and Apply Actions *}
						<div class="md:col-span-3 flex items-center justify-between pt-2">
							<a href="{url page="search"}" 
							   class="inline-flex items-center gap-1.5 text-xs font-semibold text-slate-500 hover:text-rose-600 transition">
								<i class="fa-solid fa-rotate-left"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.reset"}</span>
							</a>

							<button 
								type="submit" 
								class="px-5 py-2 rounded-xl bg-slate-800 hover:bg-slate-900 text-white text-xs font-bold transition flex items-center gap-2">
								<i class="fa-solid fa-filter text-accent"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.applyFilters"}</span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		{call_hook name="Templates::Search::SearchResults::PreResults"}

		{if $hasSearchParam}
			{* Results Status Bar *}
			<div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 mb-6 border-b border-slate-200">
				<div>
					{if !$results->wasEmpty()}
						<div class="flex items-center gap-2">
							<span class="inline-flex items-center justify-center w-7 h-7 rounded-lg bg-emerald-100 text-emerald-700 text-xs font-bold">
								<i class="fa-solid fa-check"></i>
							</span>
							<h2 class="text-base sm:text-lg font-bold text-slate-900">
								{if $results->count > 1}
									{translate key="plugins.themes.rumahJurnal.search.resultsFound" total=$results->count}
								{else}
									{translate key="plugins.themes.rumahJurnal.search.resultsFoundSingle"}
								{/if}
							</h2>
						</div>
					{else}
						<div class="flex items-center gap-2">
							<span class="inline-flex items-center justify-center w-7 h-7 rounded-lg bg-amber-100 text-amber-800 text-xs font-bold">
								<i class="fa-solid fa-triangle-exclamation"></i>
							</span>
							<h2 class="text-base sm:text-lg font-bold text-slate-800">
								{translate key="plugins.themes.rumahJurnal.search.noResultsTitle"}
							</h2>
						</div>
					{/if}

					{* Active Filter Tags *}
					<div class="flex flex-wrap items-center gap-2 mt-2">
						<span class="text-xs text-slate-400 font-medium">{translate key="plugins.themes.rumahJurnal.search.showingFor"}:</span>
						{if $query}
							<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-primary/10 text-primary">
								<span>"{$query|escape}"</span>
							</span>
						{/if}
						{if $authors}
							<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-700">
								<i class="fa-solid fa-user-pen text-[10px] text-slate-400"></i>
								<span>{$authors|escape}</span>
							</span>
						{/if}
						{if $dateFromYear || $dateToYear}
							<span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-700">
								<i class="fa-regular fa-calendar text-[10px] text-slate-400"></i>
								<span>{$dateFromYear|default:"..."} - {$dateToYear|default:"..."}</span>
							</span>
						{/if}
					</div>
				</div>

				{* Reset Quick Link if filters active *}
				<div>
					<a href="{url page="search"}" 
					   class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-slate-200 text-xs font-semibold text-slate-600 hover:text-rose-600 hover:border-rose-200 hover:bg-rose-50/50 transition">
						<i class="fa-solid fa-xmark"></i>
						<span>{translate key="plugins.themes.rumahJurnal.search.reset"}</span>
					</a>
				</div>
			</div>

			{* Results List OR Empty State *}
			{if !$results->wasEmpty()}
				<div class="space-y-4">
					{iterate from=results item=result}
						{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=false heading="h3"}
					{/iterate}
				</div>

				{* Pagination *}
				<div class="mt-10 flex flex-col sm:flex-row items-center justify-between gap-4 p-4 bg-white rounded-2xl border border-slate-200/90 shadow-sm">
					<div class="text-xs sm:text-sm text-slate-500 font-medium">
						{page_info iterator=$results}
					</div>
					<div class="cmp_pagination flex flex-wrap items-center gap-1.5 [&_a]:px-3.5 [&_a]:py-1.5 [&_a]:rounded-xl [&_a]:border [&_a]:border-slate-200 [&_a]:text-xs [&_a]:font-semibold [&_a]:text-slate-700 hover:[&_a]:bg-primary hover:[&_a]:text-white hover:[&_a]:border-primary [&_a]:transition duration-150 [&_strong]:px-3.5 [&_strong]:py-1.5 [&_strong]:rounded-xl [&_strong]:bg-primary [&_strong]:text-white [&_strong]:text-xs [&_strong]:font-bold [&_strong]:shadow-sm">
						{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear}
					</div>
				</div>

			{else}
				{* Empty State Card (When search was performed but zero matches) *}
				<div class="bg-white rounded-3xl border border-slate-200/90 p-8 sm:p-14 text-center max-w-2xl mx-auto shadow-sm my-6">
					<div class="w-20 h-20 rounded-3xl bg-amber-50 border border-accent/30 text-accent flex items-center justify-center mx-auto mb-6 shadow-sm">
						<i class="fa-solid fa-magnifying-glass text-3xl"></i>
					</div>

					<h3 class="text-xl sm:text-2xl font-extrabold text-slate-900 mb-2">
						{translate key="plugins.themes.rumahJurnal.search.noResultsTitle"}
					</h3>
					<p class="text-sm text-slate-600 leading-relaxed mb-8 max-w-md mx-auto">
						{translate key="plugins.themes.rumahJurnal.search.noResultsDesc"}
					</p>

					{* Search Tips Box *}
					<div class="bg-slate-50 rounded-2xl p-5 sm:p-6 border border-slate-200/80 text-left max-w-lg mx-auto">
						<div class="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-slate-800 mb-3">
							<i class="fa-regular fa-lightbulb text-accent text-sm"></i>
							<span>{translate key="plugins.themes.rumahJurnal.search.searchTips"}</span>
						</div>
						<ul class="space-y-2 text-xs sm:text-sm text-slate-600">
							<li class="flex items-start gap-2">
								<i class="fa-solid fa-check text-emerald-500 text-xs mt-1"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.tip1"}</span>
							</li>
							<li class="flex items-start gap-2">
								<i class="fa-solid fa-check text-emerald-500 text-xs mt-1"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.tip2"}</span>
							</li>
							<li class="flex items-start gap-2">
								<i class="fa-solid fa-check text-emerald-500 text-xs mt-1"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.tip3"}</span>
							</li>
							<li class="flex items-start gap-2">
								<i class="fa-solid fa-check text-emerald-500 text-xs mt-1"></i>
								<span>{translate key="plugins.themes.rumahJurnal.search.tip4"}</span>
							</li>
						</ul>
					</div>

					<div class="mt-8">
						<a href="{url page="search"}" 
						   class="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-primary hover:bg-primary-900 text-white text-xs sm:text-sm font-bold shadow-md hover:shadow transition duration-200">
							<i class="fa-solid fa-rotate-left text-accent"></i>
							<span>{translate key="plugins.themes.rumahJurnal.search.reset"}</span>
						</a>
					</div>
				</div>
			{/if}

		{else}
			{* Initial Welcome & Guide State (When user first lands on search page, no query yet) *}
			<div class="bg-white rounded-3xl border border-slate-200/90 p-8 sm:p-10 shadow-sm my-4">
				<div class="max-w-2xl mx-auto text-center mb-10">
					<div class="inline-flex items-center justify-center w-12 h-12 rounded-2xl bg-primary-50 text-primary mb-3">
						<i class="fa-solid fa-compass text-xl"></i>
					</div>
					<h3 class="text-xl sm:text-2xl font-extrabold text-slate-900 mb-2">
						{translate key="plugins.themes.rumahJurnal.search.initialGuideTitle"}
					</h3>
					<p class="text-xs sm:text-sm text-slate-600 leading-relaxed">
						{translate key="plugins.themes.rumahJurnal.search.initialGuideDesc"}
					</p>
				</div>

				<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
					{* Guide 1 *}
					<div class="rounded-2xl border border-slate-100 bg-slate-50/60 p-6 hover:border-primary/30 hover:bg-white hover:shadow-md transition duration-200 flex flex-col">
						<div class="w-11 h-11 rounded-xl bg-primary/10 text-primary flex items-center justify-center mb-4 text-lg">
							<i class="fa-solid fa-magnifying-glass"></i>
						</div>
						<h4 class="font-bold text-slate-900 text-sm mb-1.5">
							{translate key="plugins.themes.rumahJurnal.search.guide1Title"}
						</h4>
						<p class="text-xs text-slate-600 leading-relaxed">
							{translate key="plugins.themes.rumahJurnal.search.guide1Desc"}
						</p>
					</div>

					{* Guide 2 *}
					<div class="rounded-2xl border border-slate-100 bg-slate-50/60 p-6 hover:border-accent/40 hover:bg-white hover:shadow-md transition duration-200 flex flex-col">
						<div class="w-11 h-11 rounded-xl bg-amber-50 text-amber-700 flex items-center justify-center mb-4 text-lg">
							<i class="fa-solid fa-sliders"></i>
						</div>
						<h4 class="font-bold text-slate-900 text-sm mb-1.5">
							{translate key="plugins.themes.rumahJurnal.search.guide2Title"}
						</h4>
						<p class="text-xs text-slate-600 leading-relaxed">
							{translate key="plugins.themes.rumahJurnal.search.guide2Desc"}
						</p>
					</div>

					{* Guide 3 *}
					<div class="rounded-2xl border border-slate-100 bg-slate-50/60 p-6 hover:border-emerald-200 hover:bg-white hover:shadow-md transition duration-200 flex flex-col">
						<div class="w-11 h-11 rounded-xl bg-emerald-50 text-emerald-700 flex items-center justify-center mb-4 text-lg">
							<i class="fa-solid fa-unlock-keyhole"></i>
						</div>
						<h4 class="font-bold text-slate-900 text-sm mb-1.5">
							{translate key="plugins.themes.rumahJurnal.search.guide3Title"}
						</h4>
						<p class="text-xs text-slate-600 leading-relaxed">
							{translate key="plugins.themes.rumahJurnal.search.guide3Desc"}
						</p>
					</div>
				</div>
			</div>
		{/if}

	</div>
</main>

{include file="frontend/components/footer.tpl"}
