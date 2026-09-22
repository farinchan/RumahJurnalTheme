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
	<title>{$siteTitle|default:"UIN Mahmud Yunus Batusangkar"}</title>

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
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row justify-between items-center gap-2">
			<div class="flex items-center gap-2 text-center sm:text-left">
				<span class="text-slate-300 hidden sm:inline"> {$siteTitle|default:"UIN Mahmud Yunus Batusangkar"}</span>
			</div>
			<div class="flex items-center gap-4 text-xs">
				<a href="{url page="about" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-white transition flex items-center gap-1">
					<i class="fa-solid fa-circle-info text-accent"></i> Tentang Kami
				</a>
				<span class="text-white/20">|</span>
				{if $isUserLoggedIn}
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="dashboard"}" class="text-accent hover:text-white font-semibold transition flex items-center gap-1">
						<i class="fa-solid fa-gauge-high"></i> Dashboard
					</a>
					<span class="text-white/20">|</span>
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login" op="signOut"}" class="hover:text-rose-400 transition flex items-center gap-1">
						<i class="fa-solid fa-arrow-right-from-bracket"></i> Keluar
					</a>
				{else}
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="hover:text-white transition flex items-center gap-1">
						<i class="fa-solid fa-user"></i> Masuk
					</a>
					<span class="text-white/20">|</span>
					<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="register"}" class="text-accent hover:text-white font-medium transition flex items-center gap-1">
						<i class="fa-solid fa-user-plus"></i> Daftar
					</a>
				{/if}
			</div>
		</div>
	</div>

	<!-- MAIN NAVIGATION HEADER -->
	<header class="bg-white sticky top-0 z-40 shadow-sm border-b border-slate-200/80 backdrop-blur-md bg-white/95">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3.5 flex items-center justify-between">
			<!-- BRAND LOGO -->
			<div class="flex items-center">
				{if $activeLogoUrl}
					<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="flex items-center group py-0.5">
						<img src="{$activeLogoUrl}" 
							alt="{$activeSiteLogo.altText|default:$displayPageHeaderTitle|default:$siteTitle|default:'Rumah Jurnal'|escape}" 
							class="h-10 sm:h-12 w-auto object-contain transition duration-200 group-hover:opacity-90">
					</a>
				{else}
					<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="flex items-center group py-0.5">
						<span class="font-extrabold text-xl sm:text-2xl text-primary tracking-tight group-hover:text-accent transition">{$displayPageHeaderTitle|default:$siteTitle|default:"RUMAH JURNAL"}</span>
					</a>
				{/if}
			</div>

			<!-- NAVBAR LINKS -->
			<nav class="hidden md:flex items-center gap-7 text-sm font-semibold text-slate-700">
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="{if !$requestedPage || $requestedPage == 'index'}text-primary font-bold border-b-2 border-accent pb-1{else}hover:text-primary transition{/if}">Beranda</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" class="hover:text-primary transition">Daftar Jurnal</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#indeksasi" class="hover:text-primary transition">Indeksasi</a>
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#statistik" class="hover:text-primary transition">Statistik</a>
			</nav>

			<!-- RIGHT BUTTON -->
			<div class="flex items-center gap-3">
				<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" class="inline-flex items-center gap-2 px-4 py-2 rounded-xl text-xs sm:text-sm font-bold bg-primary text-white hover:bg-accent hover:text-primary-900 shadow-sm hover:shadow-md transition duration-200">
					<i class="fa-solid fa-magnifying-glass text-xs"></i>
					<span>Jelajahi Jurnal</span>
				</a>
			</div>
		</div>
	</header>

	{* For non-index pages, wrap content in a clean container *}
	{if $requestedPage && $requestedPage != 'index'}
	<main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-10">
	{/if}
