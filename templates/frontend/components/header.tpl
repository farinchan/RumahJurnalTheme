{**
 * plugins/themes/rumahJurnal/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2026 Rumah Jurnal
 *
 * Common site frontend header for Rumah Jurnal theme.
 *}
{strip}
	{assign var="activeSiteLogo" value=$displayPageHeaderLogo|default:$siteLogo scope="global"}
	{assign var="activeLogoUrl" value="" scope="global"}
	{if $siteLogoUrl}
		{assign var="activeLogoUrl" value=$siteLogoUrl scope="global"}
	{elseif $activeSiteLogo && $activeSiteLogo.uploadName}
		{assign var="activeLogoUrl" value="`$publicFilesDir`/`$activeSiteLogo.uploadName`" scope="global"}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="csrf-token" content="{$smarty.session.token|default:''}">
	<title>{if $pageTitleTranslated}{$pageTitleTranslated|escape} | {$siteTitle|default:"Rumah Jurnal"}{elseif $pageTitle}{translate key=$pageTitle} | {$siteTitle|default:"Rumah Jurnal"}{else}{$siteTitle|default:"Rumah Jurnal"}{/if}</title>

	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

	<!-- Font Awesome 6 Icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

	<!-- Tailwind CSS (Local with CDN fallback) -->
	<script src="{$baseUrl}/plugins/themes/rumahJurnal/js/tailwind.min.js"></script>
	<style>
		:root {
			--rj-primary: {$themePrimaryColor|default:"#2C366D"};
			--rj-primary-dark: {$themePrimaryScale.900|default:"#12162E"};
			--rj-primary-900: {$themePrimaryScale.900|default:"#12162E"};
			--rj-primary-800: {$themePrimaryScale.800|default:"#181E3E"};
			--rj-primary-light: {$themePrimaryScale.400|default:"#3D4A8E"};
			--rj-primary-50: {$themePrimaryScale.50|default:"#F0F3F9"};
			--rj-primary-100: {$themePrimaryScale.100|default:"#E0E5F2"};
			--rj-gold: {$themeSecondaryColor|default:"#D2AA2A"};
			--rj-gold-hover: {$themeSecondaryScale.600|default:"#BF961C"};
			--rj-gold-light: {$themeSecondaryScale.100|default:"#F9F4E4"};
			--rj-gold-50: {$themeSecondaryScale.50|default:"#FCF9F0"};
			--rj-gold-border: {$themeSecondaryScale.300|default:"#E8CA66"};
		}
	</style>
	<script>
		if (typeof tailwind !== 'undefined') {
			tailwind.config = {
				theme: {
					extend: {
						colors: {
							primary: {
								DEFAULT: '{$themePrimaryColor|default:"#2C366D"}',
								50: '{$themePrimaryScale.50|default:"#F0F3F9"}',
								100: '{$themePrimaryScale.100|default:"#E0E5F2"}',
								200: '{$themePrimaryScale.200|default:"#C3CCE9"}',
								300: '{$themePrimaryScale.300|default:"#A5B2DE"}',
								400: '{$themePrimaryScale.400|default:"#6980C8"}',
								500: '{$themePrimaryColor|default:"#2C366D"}',
								600: '{$themePrimaryScale.600|default:"#252E5E"}',
								700: '{$themePrimaryScale.700|default:"#1F264E"}',
								800: '{$themePrimaryScale.800|default:"#181E3E"}',
								900: '{$themePrimaryScale.900|default:"#12162E"}',
							},
							accent: {
								DEFAULT: '{$themeSecondaryColor|default:"#D2AA2A"}',
								50: '{$themeSecondaryScale.50|default:"#FCF9F0"}',
								100: '{$themeSecondaryScale.100|default:"#FAF5E6"}',
								200: '{$themeSecondaryScale.200|default:"#F4E7BD"}',
								300: '{$themeSecondaryScale.300|default:"#EDD895"}',
								400: '{$themeSecondaryScale.400|default:"#DFBE4A"}',
								500: '{$themeSecondaryColor|default:"#D2AA2A"}',
								600: '{$themeSecondaryScale.600|default:"#BD9722"}',
								700: '{$themeSecondaryScale.700|default:"#98791B"}',
								800: '{$themeSecondaryScale.800|default:"#735C15"}',
								900: '{$themeSecondaryScale.900|default:"#4D3D0E"}',
							}
						},
						fontFamily: {
							sans: ['Plus Jakarta Sans', 'system-ui', 'sans-serif'],
							display: ['Outfit', 'Plus Jakarta Sans', 'sans-serif']
						}
					}
				}
			};
		}
	</script>

	<!-- Alpine.js (Local with CDN fallback) -->
	<script defer src="{$baseUrl}/plugins/themes/rumahJurnal/js/alpine.min.js"></script>

	<!-- Custom Theme Stylesheet -->
	<link rel="stylesheet" href="{$baseUrl}/plugins/themes/rumahJurnal/styles/rumah-jurnal.css?v=1.0.1">

	<!-- Theme JS -->
	<script src="{$baseUrl}/plugins/themes/rumahJurnal/js/rumah-jurnal.js?v=1.0.1"></script>

	<!-- Alpine Component Definition for Journal Directory Explorer -->
	<script>
		function initJournalExplorer() {
			let initialData = [];
			try {
				const el = document.getElementById('rj-journals-data');
				if (el && el.textContent) {
					initialData = JSON.parse(el.textContent);
				}
			} catch(e) {
				console.error('Error parsing journals data:', e);
			}

			return {
				searchQuery: '',
				selectedCategory: 'all',
				sortBy: 'name_asc',
				viewMode: 'grid',
				journals: initialData,
				get filteredJournals() {
					let list = this.journals.filter(j => {
						const q = this.searchQuery.toLowerCase().trim();
						const matchQuery = !q ||
							(j.name && j.name.toLowerCase().includes(q)) ||
							(j.path && j.path.toLowerCase().includes(q)) ||
							(j.cleanDescription && j.cleanDescription.toLowerCase().includes(q)) ||
							(j.printIssn && j.printIssn.toLowerCase().includes(q)) ||
							(j.onlineIssn && j.onlineIssn.toLowerCase().includes(q)) ||
							(j.category && j.category.toLowerCase().includes(q)) ||
							(j.sintaLevel && j.sintaLevel.toLowerCase().includes(q));

						if (!matchQuery) return false;

						if (this.selectedCategory === 'all') return true;
						return j.category === this.selectedCategory;
					});

					if (this.sortBy === 'name_asc') {
						list.sort((a, b) => (a.name || '').localeCompare(b.name || ''));
					} else if (this.sortBy === 'name_desc') {
						list.sort((a, b) => (b.name || '').localeCompare(a.name || ''));
					} else if (this.sortBy === 'articles_desc') {
						list.sort((a, b) => (b.articleCount || 0) - (a.articleCount || 0));
					} else if (this.sortBy === 'issues_desc') {
						list.sort((a, b) => (b.issueCount || 0) - (a.issueCount || 0));
					}

					return list;
				},
				resetFilters() {
					this.searchQuery = '';
					this.selectedCategory = 'all';
					this.sortBy = 'name_asc';
				}
			};
		}

		if (window.Alpine) {
			Alpine.data('journalExplorer', initJournalExplorer);
		} else {
			document.addEventListener('alpine:init', () => {
				Alpine.data('journalExplorer', initJournalExplorer);
			});
		}
	</script>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>

<body class="bg-slate-50 text-slate-800 antialiased min-h-screen flex flex-col font-sans pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}"{if !$requestedPage || $requestedPage == 'index'} x-data="journalExplorer"{/if}>

	<!-- TOP INSTITUTIONAL BAR -->
	<div class="bg-primary-900 text-slate-300 text-xs py-2 border-b border-white/10">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-row justify-between items-center gap-2">
			<div class="flex items-center gap-2 text-left">
				<span class="text-slate-300"> {$siteTitle|default:"UIN Mahmud Yunus Batusangkar"}</span>
			</div>
			<div class="flex items-center text-xs">
				<a href="{url page="about" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-white transition flex items-center gap-1.5">
					<i class="fa-solid fa-circle-info text-accent"></i> <span>{translate key="navigation.about"}</span>
				</a>
			</div>
		</div>
	</div>

	<!-- MAIN NAVIGATION HEADER -->
	<header class="bg-white sticky top-0 z-40 shadow-sm border-b border-slate-200/80 backdrop-blur-md bg-white/95" x-data="{ mobileMenuOpen: false }">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3 sm:py-3.5 flex items-center justify-between">
			<!-- BRAND LOGO -->
			<div class="flex items-center">
				{if $activeLogoUrl}
					<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="flex items-center group py-0.5">
						<img src="{$activeLogoUrl}" 
							alt="{$activeSiteLogo.altText|default:$displayPageHeaderTitle|default:$siteTitle|default:'Rumah Jurnal'|escape}" 
							class="h-9 sm:h-12 w-auto object-contain transition duration-200 group-hover:opacity-90">
					</a>
				{else}
					<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="flex items-center group py-0.5">
						<span class="font-extrabold text-xl sm:text-2xl text-primary tracking-tight group-hover:text-accent transition">{$displayPageHeaderTitle|default:$siteTitle|default:"RUMAH JURNAL"}</span>
					</a>
				{/if}
			</div>

			<!-- NAVBAR LINKS (DESKTOP) -->
			<nav class="hidden md:flex items-center gap-7 text-sm font-semibold text-slate-700">
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="{if !$requestedPage || $requestedPage == 'index'}text-primary font-bold border-b-2 border-accent pb-1{else}hover:text-primary transition{/if}">{translate key="common.homepageNavigationLabel"}</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" class="hover:text-primary transition">{translate key="plugins.themes.rumahJurnal.nav.journalList"}</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#indeksasi" class="hover:text-primary transition">{translate key="plugins.themes.rumahJurnal.nav.indexing"}</a>
			</nav>

			<!-- RIGHT CONTROLS: AUTH BUTTONS & MOBILE TOGGLE -->
			<div class="flex items-center gap-2 sm:gap-3">
				{if $isUserLoggedIn}
					<!-- Desktop User Dropdown Menu -->
					<div class="relative hidden md:block" x-data="{ userMenuOpen: false }">
						<button 
							type="button" 
							@click="userMenuOpen = !userMenuOpen" 
							@click.outside="userMenuOpen = false"
							class="inline-flex items-center gap-2 px-3 py-2 rounded-xl text-xs sm:text-sm font-semibold bg-slate-100 hover:bg-slate-200 text-slate-800 transition focus:outline-none focus:ring-2 focus:ring-primary/20 border border-slate-200/70"
							:aria-expanded="userMenuOpen.toString()">
							<span class="w-6 h-6 rounded-full bg-primary text-white flex items-center justify-center text-xs font-bold shadow-xs">
								{$loggedInUsername|truncate:1:""|upper|default:"U"}
							</span>
							<span class="max-w-[120px] truncate font-medium">{$loggedInUsername|escape}</span>
							<i class="fa-solid fa-chevron-down text-[10px] text-slate-500 transition-transform duration-200" :class="{ 'rotate-180': userMenuOpen }"></i>
						</button>

						<!-- Dropdown Menu -->
						<div 
							x-show="userMenuOpen" 
							x-cloak
							x-transition:enter="transition ease-out duration-150"
							x-transition:enter-start="opacity-0 scale-95 -translate-y-1"
							x-transition:enter-end="opacity-100 scale-100 translate-y-0"
							x-transition:leave="transition ease-in duration-100"
							x-transition:leave-start="opacity-100 scale-100 translate-y-0"
							x-transition:leave-end="opacity-0 scale-95 -translate-y-1"
							class="absolute right-0 mt-2 w-56 bg-white rounded-2xl border border-slate-100 shadow-xl py-1.5 z-50">
							
							<div class="px-4 py-2.5 border-b border-slate-100">
								<p class="text-[11px] text-slate-400 font-medium">{translate key="plugins.themes.rumahJurnal.loggedInAs"|default:"Masuk sebagai"}</p>
								<p class="text-sm font-bold text-slate-800 truncate">{$loggedInUsername|escape}</p>
							</div>

							<div class="py-1">
								<!-- Dashboard -->
								<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="dashboard"}" 
								   class="flex items-center gap-3 px-4 py-2 text-xs font-semibold text-slate-700 hover:bg-primary-50 hover:text-primary transition">
									<i class="fa-solid fa-gauge-high text-accent w-4 text-center"></i>
									<span>{translate key="navigation.dashboard"}</span>
								</a>

								<!-- View Profile -->
								<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}" 
								   class="flex items-center gap-3 px-4 py-2 text-xs font-semibold text-slate-700 hover:bg-primary-50 hover:text-primary transition">
									<i class="fa-solid fa-id-badge text-accent w-4 text-center"></i>
									<span>{translate key="common.viewProfile"|default:"Lihat Profil"}</span>
								</a>

								<!-- Administration (if admin) -->
								{if $isSiteAdmin || ($currentUser && $currentUser->hasRole(1, 0))}
								<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE context="index" page="admin" op="index"}" 
								   class="flex items-center gap-3 px-4 py-2 text-xs font-semibold text-amber-700 hover:bg-amber-50 transition">
									<i class="fa-solid fa-screwdriver-wrench text-amber-500 w-4 text-center"></i>
									<span>{translate key="navigation.admin"|default:"Administrasi"}</span>
								</a>
								{/if}
							</div>

							<div class="pt-1 border-t border-slate-100">
								<!-- Logout -->
								<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login" op="signOut"}" 
								   class="flex items-center gap-3 px-4 py-2 text-xs font-semibold text-rose-600 hover:bg-rose-50 transition">
									<i class="fa-solid fa-arrow-right-from-bracket w-4 text-center"></i>
									<span>{translate key="user.logOut"}</span>
								</a>
							</div>
						</div>
					</div>
				{else}
					<!-- Desktop Auth Buttons (Login & Register) -->
					<div class="hidden md:flex items-center gap-1.5">
						<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" 
						   class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs sm:text-sm font-semibold text-slate-700 hover:text-primary hover:bg-slate-100 transition">
							<i class="fa-solid fa-user text-xs text-slate-400"></i>
							<span>{translate key="user.login"}</span>
						</a>
						<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="register"}" 
						   class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs sm:text-sm font-semibold text-primary bg-primary-50 hover:bg-primary-100 hover:text-primary-800 transition">
							<i class="fa-solid fa-user-plus text-xs text-accent"></i>
							<span>{translate key="user.register"}</span>
						</a>
					</div>
				{/if}

				<!-- Mobile Hamburger Button -->
				<button 
					type="button" 
					@click="mobileMenuOpen = !mobileMenuOpen" 
					class="md:hidden inline-flex items-center justify-center w-10 h-10 rounded-xl bg-slate-100 text-slate-700 hover:text-primary hover:bg-slate-200 transition focus:outline-none focus:ring-2 focus:ring-primary/20"
					:aria-expanded="mobileMenuOpen.toString()"
					aria-label="Menu navigasi">
					<i class="fa-solid text-base transition-transform duration-200" :class="mobileMenuOpen ? 'fa-xmark rotate-90 text-primary' : 'fa-bars'"></i>
				</button>
			</div>
		</div>

		<!-- MOBILE NAVIGATION DRAWER / DROPDOWN -->
		<div 
			x-show="mobileMenuOpen" 
			x-cloak
			x-transition:enter="transition ease-out duration-200"
			x-transition:enter-start="opacity-0 -translate-y-2"
			x-transition:enter-end="opacity-100 translate-y-0"
			x-transition:leave="transition ease-in duration-150"
			x-transition:leave-start="opacity-100 translate-y-0"
			x-transition:leave-end="opacity-0 -translate-y-2"
			@click.outside="mobileMenuOpen = false"
			class="md:hidden border-t border-slate-200/80 bg-white/98 backdrop-blur-md px-4 pt-3 pb-6 shadow-xl space-y-3">
			
			<!-- Mobile Nav Links -->
			<nav class="space-y-1">
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" 
				   @click="mobileMenuOpen = false"
				   class="flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-sm font-bold {if !$requestedPage || $requestedPage == 'index'}bg-primary-50 text-primary{else}text-slate-700 hover:bg-slate-50 hover:text-primary{/if} transition">
					<i class="fa-solid fa-house text-accent w-5 text-center"></i>
					<span>{translate key="common.homepageNavigationLabel"}</span>
				</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" 
				   @click="mobileMenuOpen = false"
				   class="flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-sm font-bold text-slate-700 hover:bg-slate-50 hover:text-primary transition">
					<i class="fa-solid fa-book-bookmark text-accent w-5 text-center"></i>
					<span>{translate key="plugins.themes.rumahJurnal.nav.journalList"}</span>
				</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#indeksasi" 
				   @click="mobileMenuOpen = false"
				   class="flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-sm font-bold text-slate-700 hover:bg-slate-50 hover:text-primary transition">
					<i class="fa-solid fa-shield-halved text-accent w-5 text-center"></i>
					<span>{translate key="plugins.themes.rumahJurnal.nav.indexing"}</span>
				</a>
				<a href="{url page="search" router=PKP\core\PKPApplication::ROUTE_PAGE}" 
				   @click="mobileMenuOpen = false"
				   class="flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-sm font-bold {if $requestedPage == 'search'}bg-primary-50 text-primary{else}text-slate-700 hover:bg-slate-50 hover:text-primary{/if} transition">
					<i class="fa-solid fa-magnifying-glass text-accent w-5 text-center"></i>
					<span>{translate key="common.search"}</span>
				</a>
				<a href="{url page="about" router=PKP\core\PKPApplication::ROUTE_PAGE}" 
				   @click="mobileMenuOpen = false"
				   class="flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-sm font-bold {if $requestedPage == 'about'}bg-primary-50 text-primary{else}text-slate-700 hover:bg-slate-50 hover:text-primary{/if} transition">
					<i class="fa-solid fa-circle-info text-accent w-5 text-center"></i>
					<span>{translate key="navigation.about"}</span>
				</a>
			</nav>

			<!-- Mobile Auth Links -->
			<div class="pt-3 border-t border-slate-100 flex flex-col gap-2">
				{if $isUserLoggedIn}
					<!-- User Info Card -->
					<div class="px-3.5 py-2.5 bg-slate-50 rounded-xl flex items-center gap-3 border border-slate-100 mb-1">
						<span class="w-9 h-9 rounded-full bg-primary text-white flex items-center justify-center text-xs font-bold shadow-xs">
							{$loggedInUsername|truncate:1:""|upper|default:"U"}
						</span>
						<div class="flex-1 min-w-0">
							<p class="text-[10px] uppercase font-bold tracking-wider text-slate-400">{translate key="plugins.themes.rumahJurnal.loggedInAs"|default:"Masuk sebagai"}</p>
							<p class="text-xs font-bold text-slate-800 truncate">{$loggedInUsername|escape}</p>
						</div>
					</div>

					<!-- Dashboard -->
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="dashboard"}" 
					   @click="mobileMenuOpen = false"
					   class="flex items-center gap-3 w-full py-2.5 px-3.5 rounded-xl text-xs font-bold bg-slate-100 hover:bg-slate-200 text-slate-800 transition">
						<i class="fa-solid fa-gauge-high text-accent w-4 text-center"></i>
						<span>{translate key="navigation.dashboard"}</span>
					</a>

					<!-- View Profile -->
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}" 
					   @click="mobileMenuOpen = false"
					   class="flex items-center gap-3 w-full py-2.5 px-3.5 rounded-xl text-xs font-bold bg-slate-100 hover:bg-slate-200 text-slate-800 transition">
						<i class="fa-solid fa-id-badge text-accent w-4 text-center"></i>
						<span>{translate key="common.viewProfile"|default:"Lihat Profil"}</span>
					</a>

					<!-- Administration (if admin) -->
					{if $isSiteAdmin || ($currentUser && $currentUser->hasRole(1, 0))}
						<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE context="index" page="admin" op="index"}" 
						   @click="mobileMenuOpen = false"
						   class="flex items-center gap-3 w-full py-2.5 px-3.5 rounded-xl text-xs font-bold bg-amber-50 hover:bg-amber-100 text-amber-900 border border-amber-200/60 transition">
							<i class="fa-solid fa-screwdriver-wrench text-amber-600 w-4 text-center"></i>
							<span>{translate key="navigation.admin"|default:"Administrasi"}</span>
						</a>
					{/if}

					<!-- Logout -->
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login" op="signOut"}" 
					   @click="mobileMenuOpen = false"
					   class="flex items-center justify-center gap-2 w-full py-2.5 px-3.5 rounded-xl text-xs font-semibold text-rose-600 bg-rose-50 hover:bg-rose-100 transition mt-1">
						<i class="fa-solid fa-arrow-right-from-bracket"></i>
						<span>{translate key="user.logOut"}</span>
					</a>
				{else}
					<div class="grid grid-cols-2 gap-2">
						<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" 
						   class="flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl text-xs font-bold bg-slate-100 hover:bg-slate-200 text-slate-700 transition">
							<i class="fa-solid fa-user text-slate-500"></i>
							<span>{translate key="user.login"}</span>
						</a>
						<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="register"}" 
						   class="flex items-center justify-center gap-2 py-2.5 px-3 rounded-xl text-xs font-bold bg-accent/20 hover:bg-accent text-primary-900 transition">
							<i class="fa-solid fa-user-plus text-primary"></i>
							<span>{translate key="user.register"}</span>
						</a>
					</div>
				{/if}
			</div>
		</div>
	</header>

	{* For non-index pages, wrap content in a clean container *}
	{if $requestedPage && $requestedPage != 'index'}
	<main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-10">
	{/if}
