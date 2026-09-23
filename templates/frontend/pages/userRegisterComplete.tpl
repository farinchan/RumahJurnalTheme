{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Modern registration complete page for Rumah Jurnal theme.
 *}
{include file="frontend/components/header.tpl" pageTitle=$pageTitle|default:"user.login.registrationComplete"}

<div class="py-6 sm:py-10 max-w-xl mx-auto">
	<!-- BREADCRUMBS -->
	<nav class="flex items-center gap-2 text-xs text-slate-500 mb-8" aria-label="Breadcrumb">
		<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-primary transition flex items-center gap-1.5 font-medium">
			<i class="fa-solid fa-house text-slate-400"></i>
			<span>{translate key="common.homepageNavigationLabel"}</span>
		</a>
		<i class="fa-solid fa-chevron-right text-[10px] text-slate-400"></i>
		<span class="text-slate-800 font-semibold">{translate key=$pageTitle|default:"user.login.registrationComplete"}</span>
	</nav>

	<!-- SUCCESS CARD -->
	<div class="bg-white rounded-2xl shadow-xl shadow-slate-200/70 border border-slate-200/90 relative overflow-hidden text-center p-8 sm:p-12">
		<!-- Top Accent Gradient Line -->
		<div class="h-1.5 w-full bg-gradient-to-r from-emerald-500 via-accent to-primary absolute top-0 left-0"></div>

		<!-- Success Badge -->
		<div class="w-16 h-16 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center text-3xl font-bold mx-auto mb-5 shadow-inner">
			<i class="fa-solid fa-circle-check"></i>
		</div>

		<h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight mb-3">
			{translate key=$pageTitle|default:"user.login.registrationComplete"}
		</h1>

		<p class="text-xs sm:text-sm text-slate-600 leading-relaxed max-w-md mx-auto mb-8">
			{translate key="user.login.registrationComplete.instructions"}
		</p>

		<!-- Action Links Grid -->
		<div class="space-y-3 max-w-md mx-auto text-left">
			{if array_intersect(array(PKP\security\Role::ROLE_ID_MANAGER, PKP\security\Role::ROLE_ID_SUB_EDITOR, PKP\security\Role::ROLE_ID_ASSISTANT, PKP\security\Role::ROLE_ID_REVIEWER), (array)$userRoles)}
				<a href="{url page="submissions"}"
					class="flex items-center justify-between p-3.5 rounded-xl border border-slate-200 bg-slate-50/70 hover:bg-slate-100 hover:border-slate-300 transition group">
					<div class="flex items-center gap-3">
						<div class="w-9 h-9 rounded-lg bg-primary/10 text-primary flex items-center justify-center text-sm">
							<i class="fa-solid fa-table-columns"></i>
						</div>
						<span class="text-xs sm:text-sm font-bold text-slate-800 group-hover:text-primary transition">
							{translate key="user.login.registrationComplete.manageSubmissions"}
						</span>
					</div>
					<i class="fa-solid fa-chevron-right text-xs text-slate-400 group-hover:translate-x-0.5 transition"></i>
				</a>
			{/if}

			{if $currentContext}
				<a href="{url page="submission"}"
					class="flex items-center justify-between p-3.5 rounded-xl border border-accent/40 bg-accent/10 hover:bg-accent/20 transition group">
					<div class="flex items-center gap-3">
						<div class="w-9 h-9 rounded-lg bg-accent text-white flex items-center justify-center text-sm">
							<i class="fa-solid fa-file-arrow-up"></i>
						</div>
						<span class="text-xs sm:text-sm font-bold text-slate-800 group-hover:text-primary transition">
							{translate key="user.login.registrationComplete.newSubmission"}
						</span>
					</div>
					<i class="fa-solid fa-chevron-right text-xs text-accent group-hover:translate-x-0.5 transition"></i>
				</a>
			{/if}

			<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}"
				class="flex items-center justify-between p-3.5 rounded-xl border border-slate-200 bg-slate-50/70 hover:bg-slate-100 hover:border-slate-300 transition group">
				<div class="flex items-center gap-3">
					<div class="w-9 h-9 rounded-lg bg-primary/10 text-primary flex items-center justify-center text-sm">
						<i class="fa-solid fa-user-pen"></i>
					</div>
					<span class="text-xs sm:text-sm font-bold text-slate-800 group-hover:text-primary transition">
						{translate key="user.editMyProfile"}
					</span>
				</div>
				<i class="fa-solid fa-chevron-right text-xs text-slate-400 group-hover:translate-x-0.5 transition"></i>
			</a>

			<a href="{url page="index"}"
				class="flex items-center justify-between p-3.5 rounded-xl border border-slate-200 bg-slate-50/70 hover:bg-slate-100 hover:border-slate-300 transition group">
				<div class="flex items-center gap-3">
					<div class="w-9 h-9 rounded-lg bg-primary/10 text-primary flex items-center justify-center text-sm">
						<i class="fa-solid fa-house"></i>
					</div>
					<span class="text-xs sm:text-sm font-bold text-slate-800 group-hover:text-primary transition">
						{translate key="user.login.registrationComplete.continueBrowsing"}
					</span>
				</div>
				<i class="fa-solid fa-chevron-right text-xs text-slate-400 group-hover:translate-x-0.5 transition"></i>
			</a>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
