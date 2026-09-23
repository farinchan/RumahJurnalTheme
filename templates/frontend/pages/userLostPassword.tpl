{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2026 Rumah Jurnal
 *
 * Modern password recovery page for Rumah Jurnal theme.
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="py-6 sm:py-10 max-w-xl mx-auto">
	<!-- BREADCRUMBS -->
	<nav class="flex items-center gap-2 text-xs text-slate-500 mb-8" aria-label="Breadcrumb">
		<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-primary transition flex items-center gap-1.5 font-medium">
			<i class="fa-solid fa-house text-slate-400"></i>
			<span>{translate key="common.homepageNavigationLabel"}</span>
		</a>
		<i class="fa-solid fa-chevron-right text-[10px] text-slate-400"></i>
		<a href="{url page="login" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-primary transition font-medium">
			{translate key="user.login"}
		</a>
		<i class="fa-solid fa-chevron-right text-[10px] text-slate-400"></i>
		<span class="text-slate-800 font-semibold">{translate key="user.login.resetPassword"}</span>
	</nav>

	<!-- PASSWORD RESET CARD -->
	<div class="bg-white rounded-2xl shadow-xl shadow-slate-200/70 border border-slate-200/90 relative overflow-hidden">
		<!-- Top Accent Gradient Line -->
		<div class="h-1.5 w-full bg-gradient-to-r from-primary via-accent to-primary-light"></div>

		<div class="p-6 sm:p-10">
			<!-- Header -->
			<div class="flex items-center gap-3.5 mb-6">
				<div class="w-12 h-12 rounded-xl bg-primary-50 text-primary flex items-center justify-center text-xl font-bold flex-shrink-0 shadow-inner">
					<i class="fa-solid fa-key"></i>
				</div>
				<div>
					<h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
						{translate key="user.login.resetPassword"}
					</h1>
					<p class="text-xs sm:text-sm text-slate-500 mt-0.5">
						{translate key="plugins.themes.rumahJurnal.auth.lostPasswordSubtitle"}
					</p>
				</div>
			</div>

			<!-- Instructions -->
			<div class="p-4 rounded-xl bg-slate-50 border border-slate-200/70 text-slate-600 text-xs sm:text-sm leading-relaxed mb-6">
				{translate key="user.login.resetPasswordInstructions"}
			</div>

			<!-- Error Message Box -->
			{if $error}
				<div class="mb-6 p-4 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs sm:text-sm flex items-start gap-3" role="alert">
					<i class="fa-solid fa-circle-exclamation text-rose-500 text-lg mt-0.5 flex-shrink-0"></i>
					<div class="font-medium leading-relaxed">
						{translate key=$error reason=$reason}
					</div>
				</div>
			{/if}

			<!-- Form -->
			<form class="space-y-5" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post" role="form">
				{csrf}

				<!-- Email Field -->
				<div>
					<label for="email" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
						{translate key="user.login.registeredEmail"}
						<span class="text-rose-500" title="{translate key="common.required"}">*</span>
					</label>
					<div class="relative">
						<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
							<i class="fa-solid fa-envelope text-sm"></i>
						</div>
						<input type="email"
							name="email"
							id="email"
							value="{$email|escape}"
							required
							aria-required="true"
							autocomplete="email"
							placeholder="{translate key="plugins.themes.rumahJurnal.auth.emailPlaceholder"}"
							class="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
					</div>
				</div>

				<!-- ALTCHA Verification (if enabled) -->
				{if $altchaEnabled}
					<div class="altcha_wrapper my-3">
						<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
					</div>
				{/if}

				<!-- Submit Button -->
				<div class="pt-2">
					<button type="submit"
						class="w-full py-3.5 px-6 rounded-xl font-bold text-sm bg-primary text-white shadow-md hover:shadow-lg hover:bg-primary-800 active:scale-[0.99] transition duration-200 flex items-center justify-center gap-2.5">
						<i class="fa-solid fa-paper-plane text-sm"></i>
						<span>{translate key="user.login.resetPassword"}</span>
					</button>
				</div>

				<!-- Back to Login -->
				<div class="pt-5 border-t border-slate-100 flex items-center justify-between text-xs text-slate-600">
					<a href="{url page="login" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="font-semibold text-primary hover:text-accent transition flex items-center gap-1.5">
						<i class="fa-solid fa-arrow-left"></i>
						<span>{translate key="plugins.themes.rumahJurnal.auth.backToLogin"}</span>
					</a>
					{if !$disableUserReg}
						{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
						<a href="{$registerUrl}" class="hover:text-primary transition font-medium">
							{translate key="user.login.registerNewAccount"}
						</a>
					{/if}
				</div>
			</form>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
