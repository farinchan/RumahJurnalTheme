{**
 * plugins/themes/rumahJurnal/templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Common site frontend footer for Rumah Jurnal theme.
 *}
	{* Close non-index page wrapper if open *}
	{if $requestedPage && $requestedPage != 'index'}
	</main>
	{/if}

	<!-- MAIN PORTAL FOOTER -->
	<footer class="bg-primary-900 text-slate-300 border-t-4 border-accent pt-14 pb-8 mt-auto">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<div class="grid grid-cols-1 md:grid-cols-4 gap-10 pb-12 border-b border-white/10">
				<!-- Col 1: About Institution -->
				<div class="md:col-span-2">
					<div class="flex items-center mb-4">
						{assign var="footerLogoUrl" value=$activeLogoUrl|default:$siteLogoUrl}
						{if $footerLogoUrl}
							<div class="bg-white/95 rounded-xl p-2.5 inline-block shadow-sm">
								<img src="{$footerLogoUrl}" 
									alt="{$activeSiteLogo.altText|default:$displayPageHeaderTitle|default:$siteTitle|default:'Rumah Jurnal'|escape}" 
									class="h-9 sm:h-10 w-auto object-contain">
							</div>
						{else}
							<span class="font-extrabold text-xl text-white tracking-tight">{$displayPageHeaderTitle|default:$siteTitle|default:"RUMAH JURNAL"}</span>
						{/if}
					</div>
					{if $pageFooter}
						<div class="text-xs text-slate-300 leading-relaxed max-w-lg mb-5 [&_p]:text-xs [&_p]:text-slate-300 [&_p]:leading-relaxed [&_p]:mb-2 [&_a]:text-accent hover:[&_a]:underline">
							{$pageFooter}
						</div>
					{else}
						<p class="text-xs text-slate-300 leading-relaxed max-w-lg mb-5">
							{translate key="plugins.themes.rumahJurnal.footer.defaultAbout"}
						</p>
					{/if}
				</div>

				<!-- Col 2: Quick Links -->
				<div>
					<h5 class="font-bold text-white text-sm uppercase tracking-wider mb-4 flex items-center gap-2">
						<span class="w-1.5 h-1.5 rounded-full bg-accent"></span>
						<span>{translate key="plugins.themes.rumahJurnal.footer.quickLinks"}</span>
					</h5>
					<ul class="space-y-2.5 text-xs text-slate-300">
						{if !empty($footerQuickLinks)}
							{foreach from=$footerQuickLinks item=link}
								<li><a href="{$link.url|escape}" class="hover:text-accent transition">{$link.title|escape}</a></li>
							{/foreach}
						{else}
							<li><a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-accent transition">{translate key="plugins.themes.rumahJurnal.footer.home"}</a></li>
							<li><a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" class="hover:text-accent transition">{translate key="plugins.themes.rumahJurnal.footer.indexedJournals"}</a></li>
							<li><a href="{url page="about" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-accent transition">{translate key="plugins.themes.rumahJurnal.footer.about"}</a></li>
							<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="hover:text-accent transition">{translate key="plugins.themes.rumahJurnal.footer.login"}</a></li>
							<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="register"}" class="hover:text-accent transition">{translate key="plugins.themes.rumahJurnal.footer.register"}</a></li>
						{/if}
						<li><a href="https://nagastra.org" class="hover:text-accent transition">Theme Support</a></li>

					</ul>
				</div>

				<!-- Col 3: Contact Info -->
				<div>
					<h5 class="font-bold text-white text-sm uppercase tracking-wider mb-4 flex items-center gap-2">
						<span class="w-1.5 h-1.5 rounded-full bg-accent"></span>
						<span>{translate key="plugins.themes.rumahJurnal.footer.secretariat"}</span>
					</h5>
					<ul class="space-y-3 text-xs text-slate-300">
						<li class="flex items-start gap-2.5">
							<i class="fa-solid fa-location-dot text-accent mt-1"></i>
							<span>{$secretariatAddress|escape|nl2br}</span>
						</li>
						<li class="flex items-center gap-2.5">
							<i class="fa-solid fa-envelope text-accent"></i>
							<span>
								<a href="mailto:{$principalContactEmail|escape}" class="hover:text-accent transition">
									{$principalContactEmail|escape}
								</a>
							</span>
						</li>
						<li class="flex items-center gap-2.5">
							<i class="fa-solid fa-globe text-accent"></i>
							<span>
								<a href="{$siteUrl|default:$baseUrl|escape}" target="_blank" rel="noopener noreferrer" class="hover:text-accent transition">
									{$siteUrl|default:$baseUrl|escape}
								</a>
							</span>
						</li>
					</ul>
				</div>
			</div>

			<!-- BOTTOM COPYRIGHT & OJS INFO -->
			<div class="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-400">
				<div>
					&copy; {$smarty.now|date_format:"Y"} <strong>{$siteTitle|default:"UIN Mahmud Yunus Batusangkar"}</strong>. {translate key="plugins.themes.rumahJurnal.footer.allRightsReserved"}
				</div>
			</div>
		</div>
	</footer>

	<!-- BACK TO TOP BUTTON -->
	<button
		x-data="{ showTop: false }"
		@scroll.window="showTop = (window.pageYOffset > 400)"
		x-show="showTop"
		@click="window.scrollTo({ top: 0, behavior: 'smooth' })"
		x-transition
		class="fixed bottom-6 right-6 z-40 w-11 h-11 rounded-xl bg-primary text-white shadow-xl hover:bg-accent hover:text-primary-900 border border-accent/50 flex items-center justify-center transition duration-200"
		title="{translate key="plugins.themes.rumahJurnal.footer.backToTop"}">
		<i class="fa-solid fa-arrow-up text-sm"></i>
	</button>

	{load_script context="frontend"}
	{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
