{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2026 Rumah Jurnal
 *
 * Portal Homepage / Site Index for Rumah Jurnal (OJS 3.5)
 *}
{include file="frontend/components/header.tpl" pageTitle="plugins.themes.rumahJurnal.portalTitle"}

<!-- Journal Dataset (Safely Serialized in JSON Script Tag) -->
<script type="application/json" id="rj-journals-data">
{$journalsJson}
</script>

	<!-- HERO BANNER SECTION -->
	<section class="rj-hero-bg text-white pt-16 pb-20 px-4 sm:px-6 lg:px-8 border-b-4 border-accent">
		<div class="max-w-6xl mx-auto text-center relative z-10">

			<!-- MAIN HEADLINE -->
			<h1 class="text-3xl sm:text-4xl lg:text-5xl font-extrabold tracking-tight text-white mb-4 leading-tight">
				{$heroTitle|escape}
			</h1>
			<p class="text-base sm:text-lg text-slate-200 max-w-3xl mx-auto mb-10 font-normal leading-relaxed">
				{$heroDescription}
			</p>

			<!-- HERO SEARCH BAR (SUBMITS TO SEARCH PAGE) -->
			<div class="max-w-3xl mx-auto mb-12">
				<form action="{url page="search"}" method="get" class="relative flex items-center shadow-2xl rounded-2xl overflow-hidden bg-white text-slate-800 p-2 border-2 border-white/80 focus-within:border-accent transition">
					<div class="pl-4 text-slate-400">
						<i class="fa-solid fa-magnifying-glass text-lg text-primary"></i>
					</div>
					<input
						type="text"
						name="query"
						placeholder="{translate key="plugins.themes.rumahJurnal.search.inputPlaceholder"}"
						class="w-full py-3.5 px-4 text-sm sm:text-base font-medium text-slate-800 placeholder-slate-400 bg-transparent focus:outline-none"
						required
					>
					<button
						type="submit"
						class="inline-flex items-center gap-2 bg-primary hover:bg-accent hover:text-primary-900 text-white px-6 sm:px-8 py-3.5 rounded-xl font-bold text-sm transition duration-200 shadow-sm flex-shrink-0">
						<span>{translate key="common.search"}</span>
						<i class="fa-solid fa-arrow-right text-xs"></i>
					</button>
				</form>
				<!-- Search hints -->
				<div class="flex flex-wrap items-center justify-center gap-2 mt-3 text-xs text-slate-300">
					<span class="text-slate-400">{translate key="plugins.themes.rumahJurnal.popularSearches"}</span>
					<a href="{url page="search" query="hukum"}" class="px-2.5 py-0.5 rounded-full bg-white/10 hover:bg-accent hover:text-primary-900 transition text-accent">#{translate key="plugins.themes.rumahJurnal.tag.law"}</a>
					<a href="{url page="search" query="syariah"}" class="px-2.5 py-0.5 rounded-full bg-white/10 hover:bg-white/20 transition">#{translate key="plugins.themes.rumahJurnal.tag.sharia"}</a>
					<a href="{url page="search" query="pendidikan"}" class="px-2.5 py-0.5 rounded-full bg-white/10 hover:bg-white/20 transition">#{translate key="plugins.themes.rumahJurnal.tag.education"}</a>
					<a href="{url page="search" query="ekonomi"}" class="px-2.5 py-0.5 rounded-full bg-white/10 hover:bg-white/20 transition">#{translate key="plugins.themes.rumahJurnal.tag.economics"}</a>
					<a href="{url page="search" query="sainstek"}" class="px-2.5 py-0.5 rounded-full bg-white/10 hover:bg-white/20 transition">#{translate key="plugins.themes.rumahJurnal.tag.science"}</a>
				</div>
			</div>

			<!-- PORTAL STATISTIC CARDS -->
			<div id="statistik" class="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6 pt-4">
				<!-- Stat 1 -->
				<div class="rj-stat-card p-5 text-center transform hover:-translate-y-1 transition duration-200">
					<div class="w-10 h-10 mx-auto mb-2 rounded-lg bg-accent/20 flex items-center justify-center text-accent">
						<i class="fa-solid fa-book text-lg"></i>
					</div>
					<div class="text-2xl sm:text-3xl font-extrabold text-white">{$portalTotalJournals|default:41}</div>
					<div class="text-xs text-slate-300 font-medium uppercase tracking-wider mt-1">{translate key="plugins.themes.rumahJurnal.stats.registeredJournals"}</div>
				</div>
				<!-- Stat 2 -->
				<div class="rj-stat-card p-5 text-center transform hover:-translate-y-1 transition duration-200">
					<div class="w-10 h-10 mx-auto mb-2 rounded-lg bg-accent/20 flex items-center justify-center text-accent">
						<i class="fa-solid fa-newspaper text-lg"></i>
					</div>
					<div class="text-2xl sm:text-3xl font-extrabold text-white">{$portalTotalArticles|number_format:0:',':'.'|default:'4.670'}+</div>
					<div class="text-xs text-slate-300 font-medium uppercase tracking-wider mt-1">{translate key="plugins.themes.rumahJurnal.stats.publishedArticles"}</div>
				</div>
				<!-- Stat 3 -->
				<div class="rj-stat-card p-5 text-center transform hover:-translate-y-1 transition duration-200">
					<div class="w-10 h-10 mx-auto mb-2 rounded-lg bg-accent/20 flex items-center justify-center text-accent">
						<i class="fa-solid fa-layer-group text-lg"></i>
					</div>
					<div class="text-2xl sm:text-3xl font-extrabold text-white">{$portalTotalIssues|default:480}+</div>
					<div class="text-xs text-slate-300 font-medium uppercase tracking-wider mt-1">{translate key="plugins.themes.rumahJurnal.stats.volumesIssues"}</div>
				</div>
				<!-- Stat 4 -->
				<div class="rj-stat-card p-5 text-center transform hover:-translate-y-1 transition duration-200">
					<div class="w-10 h-10 mx-auto mb-2 rounded-lg bg-accent/20 flex items-center justify-center text-accent">
						<i class="fa-solid fa-certificate text-lg"></i>
					</div>
					<div class="text-2xl sm:text-3xl font-extrabold text-white">{$portalTotalSinta|default:15}+</div>
					<div class="text-xs text-slate-300 font-medium uppercase tracking-wider mt-1">{translate key="plugins.themes.rumahJurnal.stats.sintaAccreditation"}</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ANNOUNCEMENTS BANNER (IF ANY) -->
	{if $numAnnouncementsHomepage && $announcements|@count}
		<section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-6 relative z-20">
			<div class="bg-amber-50 border-l-4 border-accent p-4 rounded-xl shadow-md flex items-start gap-3">
				<i class="fa-solid fa-bullhorn text-accent text-lg mt-0.5"></i>
				<div class="flex-1">
					<h3 class="text-sm font-bold text-slate-900">{translate key="plugins.themes.rumahJurnal.latestAnnouncements"}</h3>
					<div class="text-xs text-slate-700 mt-1">
						{foreach from=$announcements item=announcement name=announcementsLoop}
							{if $smarty.foreach.announcementsLoop.index < 1}
								<a href="{url page="announcement" op="view" path=$announcement->getId()}" class="font-semibold text-primary hover:underline">
									{$announcement->getLocalizedTitle()|escape}
								</a>: {$announcement->getLocalizedDescriptionShort()|strip_tags|truncate:150}
							{/if}
						{/foreach}
					</div>
				</div>
			</div>
		</section>
	{/if}

	<!-- MAIN CONTENT: JOURNAL DIRECTORY EXPLORER -->
	<main id="daftar-jurnal" class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-12">
		<!-- SECTION HEADER & TOOLBAR -->
		<div class="mb-8">
			<div class="flex flex-col md:flex-row md:items-end justify-between gap-4 pb-6 border-b border-slate-200">
				<div>
					<div class="flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-accent mb-1">
						<i class="fa-solid fa-list-check"></i>
						<span>{translate key="plugins.themes.rumahJurnal.directory.badge"}</span>
					</div>
					<h2 class="text-2xl sm:text-3xl font-extrabold text-primary tracking-tight">
						{translate key="plugins.themes.rumahJurnal.directory.title"}
					</h2>
					<p class="text-sm text-slate-500 mt-1">
						{translate key="plugins.themes.rumahJurnal.directory.subtitle"}
					</p>
				</div>

				<!-- RIGHT CONTROLS: SORT & VIEW SWITCHER -->
				<div class="flex flex-wrap items-center gap-3">
					<!-- QUICK JOURNAL FILTER -->
					<div class="relative">
						<input
							type="text"
							x-model="searchQuery"
							placeholder="{translate key="plugins.themes.rumahJurnal.directory.filterPlaceholder"}"
							class="text-xs bg-white border border-slate-300 rounded-xl pl-8 pr-7 py-2 text-slate-700 placeholder-slate-400 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary/20 shadow-sm w-44 sm:w-56"
						>
						<div class="absolute inset-y-0 left-0 pl-2.5 flex items-center pointer-events-none text-slate-400">
							<i class="fa-solid fa-magnifying-glass text-[11px]"></i>
						</div>
						<button
							type="button"
							x-show="searchQuery"
							@click="searchQuery = ''"
							class="absolute inset-y-0 right-0 pr-2 flex items-center text-slate-400 hover:text-slate-600 transition"
							title="{translate key="plugins.themes.rumahJurnal.directory.resetFilter"}">
							<i class="fa-solid fa-xmark text-xs"></i>
						</button>
					</div>

					<!-- SORT DROPDOWN -->
					<div class="relative inline-block">
						<select
							x-model="sortBy"
							class="text-xs font-semibold bg-white border border-slate-300 rounded-xl px-3 py-2 text-slate-700 focus:outline-none focus:border-primary shadow-sm cursor-pointer pr-8">
							<option value="name_asc">{translate key="plugins.themes.rumahJurnal.sort.nameAsc"}</option>
							<option value="name_desc">{translate key="plugins.themes.rumahJurnal.sort.nameDesc"}</option>
							<option value="articles_desc">{translate key="plugins.themes.rumahJurnal.sort.articlesDesc"}</option>
							<option value="issues_desc">{translate key="plugins.themes.rumahJurnal.sort.issuesDesc"}</option>
						</select>
					</div>

					<!-- VIEW MODE BUTTONS -->
					<div class="inline-flex bg-slate-200/80 p-1 rounded-xl shadow-inner">
						<button
							@click="viewMode = 'grid'"
							:class="viewMode === 'grid' ? 'bg-white text-primary shadow-sm' : 'text-slate-600 hover:text-slate-900'"
							class="px-3 py-1.5 rounded-lg text-xs font-bold transition flex items-center gap-1.5"
							title="{translate key="plugins.themes.rumahJurnal.view.grid"}">
							<i class="fa-solid fa-table-cells-large"></i>
							<span class="hidden sm:inline">{translate key="plugins.themes.rumahJurnal.view.grid"}</span>
						</button>
						<button
							@click="viewMode = 'list'"
							:class="viewMode === 'list' ? 'bg-white text-primary shadow-sm' : 'text-slate-600 hover:text-slate-900'"
							class="px-3 py-1.5 rounded-lg text-xs font-bold transition flex items-center gap-1.5"
							title="{translate key="plugins.themes.rumahJurnal.view.list"}">
							<i class="fa-solid fa-list-ul"></i>
							<span class="hidden sm:inline">{translate key="plugins.themes.rumahJurnal.view.list"}</span>
						</button>
					</div>
				</div>
			</div>

			<!-- CATEGORY FILTER PILLS -->
			<div class="flex items-center gap-2 overflow-x-auto py-4 scrollbar-none">
				<button
					@click="selectedCategory = 'all'"
					:class="selectedCategory === 'all' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<i class="fa-solid fa-cubes text-xs"></i>
					<span>{translate key="plugins.themes.rumahJurnal.category.all"} ({$portalTotalJournals|default:41})</span>
				</button>
				<button
					@click="selectedCategory = 'Keislaman & Multidisiplin'"
					:class="selectedCategory === 'Keislaman & Multidisiplin' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.islamic"}</span>
				</button>
				<button
					@click="selectedCategory = 'Syariah & Hukum'"
					:class="selectedCategory === 'Syariah & Hukum' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.sharia"}</span>
				</button>
				<button
					@click="selectedCategory = 'Pendidikan & Tarbiyah'"
					:class="selectedCategory === 'Pendidikan & Tarbiyah' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.education"}</span>
				</button>
				<button
					@click="selectedCategory = 'Ekonomi & Bisnis Islam'"
					:class="selectedCategory === 'Ekonomi & Bisnis Islam' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.economics"}</span>
				</button>
				<button
					@click="selectedCategory = 'Sains & Teknologi'"
					:class="selectedCategory === 'Sains & Teknologi' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.science"}</span>
				</button>
				<button
					@click="selectedCategory = 'Bahasa & Sastra'"
					:class="selectedCategory === 'Bahasa & Sastra' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.language"}</span>
				</button>
				<button
					@click="selectedCategory = 'Sosial & Humaniora'"
					:class="selectedCategory === 'Sosial & Humaniora' ? 'rj-tab-active font-bold' : 'bg-white text-slate-700 hover:bg-slate-100 border border-slate-200 font-medium'"
					class="px-4 py-2 rounded-xl text-xs whitespace-nowrap transition duration-150 flex items-center gap-1.5 flex-shrink-0">
					<span>{translate key="plugins.themes.rumahJurnal.category.social"}</span>
				</button>
			</div>

			<!-- RESULT COUNT & ACTIVE FILTER BADGES -->
			<div class="flex flex-wrap items-center justify-between gap-2 pt-2 text-xs text-slate-500 font-medium">
				<div class="flex items-center gap-2">
					<span>
						{translate key="plugins.themes.rumahJurnal.directory.showing"} 
						<strong class="text-slate-800" x-text="filteredJournals.length"></strong> 
						{translate key="plugins.themes.rumahJurnal.directory.of"} 
						<strong class="text-slate-800" x-text="journals.length"></strong> 
						{translate key="plugins.themes.rumahJurnal.directory.journals"}
					</span>
					<span x-show="searchQuery || selectedCategory !== 'all'" class="text-slate-300">•</span>
					<button
						x-show="searchQuery || selectedCategory !== 'all'"
						@click="resetFilters()"
						class="text-primary hover:text-accent font-bold flex items-center gap-1">
						<i class="fa-solid fa-rotate-left"></i> 
						<span>{translate key="plugins.themes.rumahJurnal.directory.resetFilter"}</span>
					</button>
				</div>
				<div x-show="searchQuery" class="text-slate-600">
					{translate key="plugins.themes.rumahJurnal.directory.resultsFor"} "<span class="font-bold text-primary" x-text="searchQuery"></span>"
				</div>
			</div>
		</div>

		<!-- GRID VIEW OF JOURNALS -->
		<div x-show="viewMode === 'grid'" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
			<template x-for="j in filteredJournals" :key="j.id">
				<div class="rj-journal-card rounded-2xl flex flex-col justify-between overflow-hidden group">
					<!-- TOP HEADER: COVER & BADGES -->
					<div>
						<div class="relative bg-slate-50 border-b border-slate-100 overflow-hidden">
							<!-- CATEGORY BADGE -->
							<div class="absolute top-3 left-3 z-10">
								<span class="inline-flex items-center px-2.5 py-1 rounded-lg text-[11px] font-semibold bg-white/90 backdrop-blur shadow-sm text-primary border border-slate-200" x-text="j.category"></span>
							</div>

							<!-- THUMBNAIL / MONOGRAM -->
							<div class="h-48 flex items-center justify-center p-4">
								<template x-if="j.thumbnailUrl">
									<a :href="j.homeUrl" class="block h-full w-full flex items-center justify-center">
										<img :src="j.thumbnailUrl" :alt="j.name" class="rj-cover-img max-h-full max-w-full object-contain filter drop-shadow-md">
									</a>
								</template>
								<template x-if="!j.thumbnailUrl">
									<a :href="j.homeUrl" class="h-full w-full bg-gradient-to-br from-primary to-primary-900 rounded-xl flex flex-col items-center justify-center p-4 text-center group-hover:scale-[1.02] transition duration-300">
										<div class="w-14 h-14 rounded-2xl bg-white/10 backdrop-blur border border-accent/40 flex items-center justify-center text-white font-extrabold text-xl shadow-inner mb-2" x-text="j.initial"></div>
										<span class="text-xs font-bold text-white/90 line-clamp-1" x-text="j.name"></span>
									</a>
								</template>
							</div>
						</div>

						<!-- CARD BODY -->
						<div class="p-5">
							<!-- TITLE -->
							<h3 class="text-base font-bold text-primary group-hover:text-accent transition duration-150 leading-snug line-clamp-2 mb-2.5">
								<a :href="j.homeUrl" x-text="j.name"></a>
							</h3>

							<!-- ISSN BADGES -->
							<div class="flex flex-wrap items-center gap-2 mb-3 text-[11px]">
								<template x-if="j.onlineIssn">
									<span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md bg-emerald-50 text-emerald-800 border border-emerald-200 font-mono font-medium cursor-pointer hover:bg-emerald-100 transition"
										@click="copyToClipboard(j.onlineIssn, 'e-ISSN')"
										:title="'{translate key="plugins.themes.rumahJurnal.journal.clickCopy"|escape:'javascript'} e-ISSN: ' + j.onlineIssn">
										<span>e-ISSN: <strong x-text="j.onlineIssn"></strong></span>
										<i class="fa-regular fa-copy text-[10px] text-emerald-600"></i>
									</span>
								</template>
								<template x-if="j.printIssn">
									<span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md bg-slate-100 text-slate-700 border border-slate-200 font-mono font-medium cursor-pointer hover:bg-slate-200 transition"
										@click="copyToClipboard(j.printIssn, 'p-ISSN')"
										:title="'{translate key="plugins.themes.rumahJurnal.journal.clickCopy"|escape:'javascript'} p-ISSN: ' + j.printIssn">
										<span>p-ISSN: <strong x-text="j.printIssn"></strong></span>
										<i class="fa-regular fa-copy text-[10px] text-slate-500"></i>
									</span>
								</template>
							</div>

							<!-- DESCRIPTION -->
							<p class="text-xs text-slate-600 line-clamp-3 leading-relaxed mb-4" x-text="j.cleanDescription || '{translate key="plugins.themes.rumahJurnal.journal.defaultDesc"|escape:'javascript'}'"></p>

							<!-- METRICS BAR -->
							<div class="flex items-center justify-between pt-3 border-t border-slate-100 text-xs text-slate-500">
								<div class="flex items-center gap-1.5" title="{translate key="plugins.themes.rumahJurnal.journal.issues"}">
									<i class="fa-regular fa-folder-open text-accent"></i>
									<span><strong class="text-slate-800" x-text="j.issueCount"></strong> {translate key="plugins.themes.rumahJurnal.journal.issues"}</span>
								</div>
								<div class="flex items-center gap-1.5" title="{translate key="plugins.themes.rumahJurnal.journal.articles"}">
									<i class="fa-regular fa-file-lines text-primary"></i>
									<span><strong class="text-slate-800" x-text="j.articleCount"></strong> {translate key="plugins.themes.rumahJurnal.journal.articles"}</span>
								</div>
							</div>
						</div>
					</div>

					<!-- CARD FOOTER: ACTION BUTTONS -->
					<div class="p-5 pt-0 mt-auto">
						<div class="flex items-center gap-2">
							<a :href="j.homeUrl" class="flex-1 inline-flex items-center justify-center gap-1.5 px-3 py-2.5 rounded-xl text-xs font-bold bg-primary text-white hover:bg-accent hover:text-primary-900 transition duration-200 shadow-sm">
								<span>{translate key="plugins.themes.rumahJurnal.journal.visitJournal"}</span>
								<i class="fa-solid fa-arrow-up-right-from-square text-[11px]"></i>
							</a>
							<a :href="j.currentIssueUrl" class="inline-flex items-center justify-center gap-1 px-3 py-2.5 rounded-xl text-xs font-semibold bg-slate-100 hover:bg-slate-200 text-slate-700 border border-slate-200 transition duration-200" title="{translate key="plugins.themes.rumahJurnal.journal.currentIssue"}">
								<i class="fa-solid fa-book-open text-slate-500"></i>
								<span class="hidden sm:inline">{translate key="plugins.themes.rumahJurnal.journal.currentIssue"}</span>
							</a>
						</div>
					</div>
				</div>
			</template>
		</div>

		<!-- LIST / TABLE VIEW OF JOURNALS -->
		<div x-show="viewMode === 'list'" class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
			<div class="overflow-x-auto">
				<table class="w-full text-left text-xs sm:text-sm">
					<thead class="bg-slate-50 text-slate-700 font-bold border-b border-slate-200 uppercase text-[11px] tracking-wider">
						<tr>
							<th class="py-3.5 px-4 w-16">{translate key="plugins.themes.rumahJurnal.table.cover"}</th>
							<th class="py-3.5 px-4">{translate key="plugins.themes.rumahJurnal.table.journalName"}</th>
							<th class="py-3.5 px-4">{translate key="plugins.themes.rumahJurnal.table.issn"}</th>
							<th class="py-3.5 px-4 text-center">{translate key="plugins.themes.rumahJurnal.table.publications"}</th>
							<th class="py-3.5 px-4 text-right">{translate key="plugins.themes.rumahJurnal.table.action"}</th>
						</tr>
					</thead>
					<tbody class="divide-y divide-slate-100">
						<template x-for="j in filteredJournals" :key="j.id">
							<tr class="hover:bg-slate-50/80 transition">
								<!-- COVER -->
								<td class="py-3 px-4">
									<div class="w-12 h-16 bg-slate-100 rounded border border-slate-200 flex items-center justify-center overflow-hidden p-1 flex-shrink-0">
										<template x-if="j.thumbnailUrl">
											<img :src="j.thumbnailUrl" :alt="j.name" class="max-h-full max-w-full object-contain">
										</template>
										<template x-if="!j.thumbnailUrl">
											<span class="font-bold text-primary text-xs" x-text="j.initial"></span>
										</template>
									</div>
								</td>
								<!-- NAME & CATEGORY -->
								<td class="py-3 px-4">
									<a :href="j.homeUrl" class="font-bold text-primary hover:text-accent text-sm sm:text-base leading-tight block" x-text="j.name"></a>
									<span class="inline-block mt-1 text-[11px] text-slate-500 font-medium" x-text="j.category"></span>
									<p class="text-xs text-slate-500 line-clamp-1 mt-0.5" x-text="j.cleanDescription"></p>
								</td>
								<!-- ISSN -->
								<td class="py-3 px-4 whitespace-nowrap font-mono text-xs">
									<div x-show="j.onlineIssn" class="text-emerald-700">e: <strong x-text="j.onlineIssn"></strong></div>
									<div x-show="j.printIssn" class="text-slate-600">p: <strong x-text="j.printIssn"></strong></div>
									<div x-show="!j.onlineIssn && !j.printIssn" class="text-slate-400">-</div>
								</td>
								<!-- STATS -->
								<td class="py-3 px-4 text-center whitespace-nowrap text-xs">
									<div><strong class="text-slate-900" x-text="j.articleCount"></strong> {translate key="plugins.themes.rumahJurnal.journal.articles"}</div>
									<div class="text-slate-500"><span x-text="j.issueCount"></span> {translate key="plugins.themes.rumahJurnal.journal.issues"}</div>
								</td>
								<!-- ACTION -->
								<td class="py-3 px-4 text-right whitespace-nowrap">
									<div class="inline-flex items-center gap-1.5">
										<a :href="j.homeUrl" class="px-3 py-1.5 rounded-lg text-xs font-bold bg-primary text-white hover:bg-accent hover:text-primary-900 transition">
											{translate key="plugins.themes.rumahJurnal.journal.visit"}
										</a>
										<a :href="j.currentIssueUrl" class="px-2.5 py-1.5 rounded-lg text-xs font-medium bg-slate-100 hover:bg-slate-200 text-slate-700 border border-slate-200 transition" title="{translate key="plugins.themes.rumahJurnal.journal.currentIssue"}">
											<i class="fa-solid fa-book-open"></i>
										</a>
									</div>
								</td>
							</tr>
						</template>
					</tbody>
				</table>
			</div>
		</div>

		<!-- EMPTY STATE IF SEARCH FAILS -->
		<div x-show="filteredJournals.length === 0" class="text-center py-16 bg-white rounded-2xl border border-slate-200 p-8 shadow-sm">
			<div class="w-16 h-16 mx-auto mb-4 rounded-2xl bg-amber-50 border border-accent/40 flex items-center justify-center text-accent">
				<i class="fa-solid fa-magnifying-glass text-2xl"></i>
			</div>
			<h3 class="text-lg font-bold text-slate-900 mb-1">{translate key="plugins.themes.rumahJurnal.directory.noJournalsTitle"}</h3>
			<p class="text-sm text-slate-500 max-w-md mx-auto mb-6">
				{translate key="plugins.themes.rumahJurnal.directory.noJournalsDescPrefix"} "<span class="font-bold text-primary" x-text="searchQuery"></span>" {translate key="plugins.themes.rumahJurnal.directory.noJournalsDescSuffix"}
			</p>
			<button
				@click="resetFilters()"
				class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-bold bg-primary text-white hover:bg-accent hover:text-primary-900 transition shadow-sm">
				<i class="fa-solid fa-rotate-left"></i>
				<span>{translate key="plugins.themes.rumahJurnal.directory.showAllJournals"}</span>
			</button>
		</div>
	</main>

	<!-- INDEXING & PARTNER LOGOS -->
	<section id="indeksasi" class="bg-white border-y border-slate-200 py-14">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
			<div class="flex items-center justify-center gap-2 text-xs font-bold uppercase tracking-widest text-accent mb-2">
				<i class="fa-solid fa-shield-halved"></i>
				<span>{translate key="plugins.themes.rumahJurnal.indexing.badge"}</span>
			</div>
			<h3 class="text-2xl font-extrabold text-primary tracking-tight mb-3">
				{translate key="plugins.themes.rumahJurnal.indexing.title"}
			</h3>
			<p class="text-sm text-slate-600 max-w-2xl mx-auto mb-10">
				{translate key="plugins.themes.rumahJurnal.indexing.subtitle"}
			</p>

			<!-- INDEXING LOGOS -->
			<div class="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-6 lg:grid-cols-8 gap-4 items-center">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/sinta.png" alt="SINTA" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="SINTA - Science and Technology Index">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/scopus.png" alt="Scopus" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Scopus">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/garuda.png" alt="Garuda" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Garuda - Garba Rujukan Digital">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/crossref.png" alt="Crossref" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Crossref - Digital Object Identifier">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/doaj.png" alt="DOAJ" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="DOAJ - Directory of Open Access Journals">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/scholar.png" alt="Google Scholar" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Google Scholar">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/dimensions.png" alt="Dimensions" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Dimensions">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/moraref.png" alt="Moraref" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Moraref - Kementerian Agama RI">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/onesearch.png" alt="Indonesia OneSearch" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Indonesia OneSearch">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/road.png" alt="ROAD ISSN" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="ROAD - Directory of Open Access Scholarly Resources">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/copernicus.png" alt="Index Copernicus" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Index Copernicus International">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/ebsco.png" alt="EBSCO" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="EBSCO">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/base.png" alt="BASE" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="BASE - Bielefeld Academic Search Engine">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/neliti.png" alt="Neliti" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="Neliti - Repositori Ilmiah Indonesia">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/researchgate.png" alt="ResearchGate" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="ResearchGate">
				<img src="{$baseUrl}/plugins/themes/rumahJurnal/images/pkp.png" alt="PKP Index" width="380" height="129" class="w-full h-auto block hover:opacity-80 transition duration-200" loading="lazy" title="PKP Index">
			</div>
		</div>
	</section>


{include file="frontend/components/footer.tpl"}