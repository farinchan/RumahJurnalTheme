<?php

/**
 * @file plugins/themes/rumahJurnal/RumahJurnalThemePlugin.php
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * @class RumahJurnalThemePlugin
 *
 * @brief Rumah Jurnal Theme - Modern Portal Theme for OJS 3.5
 */

namespace APP\plugins\themes\rumahJurnal;

use APP\core\Application;
use APP\file\PublicFileManager;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\plugins\ThemePlugin;
use PKP\template\PKPTemplateManager;
use Illuminate\Support\Facades\DB;
use PKP\core\PKPApplication;
use PKP\security\Role;
use PKP\security\Validation;

class RumahJurnalThemePlugin extends ThemePlugin
{

    /**
     * Built-in accreditation & indexing logos catalog
     */
    public const BUILTIN_INDEXING_LOGOS = [
        'sinta' => [
            'name' => 'SINTA',
            'title' => 'SINTA - Science and Technology Index',
            'file' => 'sinta.png',
            'url' => 'https://sinta.kemdikbud.go.id/',
        ],
        'scopus' => [
            'name' => 'Scopus',
            'title' => 'Scopus',
            'file' => 'scopus.png',
            'url' => 'https://www.scopus.com/',
        ],
        'garuda' => [
            'name' => 'Garuda',
            'title' => 'Garuda - Garba Rujukan Digital',
            'file' => 'garuda.png',
            'url' => 'https://garuda.kemdikbud.go.id/',
        ],
        'crossref' => [
            'name' => 'Crossref',
            'title' => 'Crossref - Digital Object Identifier',
            'file' => 'crossref.png',
            'url' => 'https://www.crossref.org/',
        ],
        'doaj' => [
            'name' => 'DOAJ',
            'title' => 'DOAJ - Directory of Open Access Journals',
            'file' => 'doaj.png',
            'url' => 'https://doaj.org/',
        ],
        'scholar' => [
            'name' => 'Google Scholar',
            'title' => 'Google Scholar',
            'file' => 'scholar.png',
            'url' => 'https://scholar.google.com/',
        ],
        'dimensions' => [
            'name' => 'Dimensions',
            'title' => 'Dimensions',
            'file' => 'dimensions.png',
            'url' => 'https://www.dimensions.ai/',
        ],
        'moraref' => [
            'name' => 'Moraref',
            'title' => 'Moraref - Kementerian Agama RI',
            'file' => 'moraref.png',
            'url' => 'https://moraref.kemenag.go.id/',
        ],
        'onesearch' => [
            'name' => 'Indonesia OneSearch',
            'title' => 'Indonesia OneSearch',
            'file' => 'onesearch.png',
            'url' => 'https://onesearch.id/',
        ],
        'road' => [
            'name' => 'ROAD ISSN',
            'title' => 'ROAD - Directory of Open Access Scholarly Resources',
            'file' => 'road.png',
            'url' => 'https://road.issn.org/',
        ],
        'copernicus' => [
            'name' => 'Index Copernicus',
            'title' => 'Index Copernicus International',
            'file' => 'copernicus.png',
            'url' => 'https://journals.indexcopernicus.com/',
        ],
        'ebsco' => [
            'name' => 'EBSCO',
            'title' => 'EBSCO',
            'file' => 'ebsco.png',
            'url' => 'https://www.ebsco.com/',
        ],
        'base' => [
            'name' => 'BASE',
            'title' => 'BASE - Bielefeld Academic Search Engine',
            'file' => 'base.png',
            'url' => 'https://www.base-search.net/',
        ],
        'neliti' => [
            'name' => 'Neliti',
            'title' => 'Neliti - Repositori Ilmiah Indonesia',
            'file' => 'neliti.png',
            'url' => 'https://www.neliti.com/',
        ],
        'researchgate' => [
            'name' => 'ResearchGate',
            'title' => 'ResearchGate',
            'file' => 'researchgate.png',
            'url' => 'https://www.researchgate.net/',
        ],
        'pkp' => [
            'name' => 'PKP Index',
            'title' => 'PKP Index',
            'file' => 'pkp.png',
            'url' => 'https://index.pkp.sfu.ca/',
        ],
    ];

    /**
     * Initialize theme styles, scripts and template overrides
     */
    public function init()
    {
        // Register theme customizable color options for Admin Settings
        $this->addOption('primaryColor', 'FieldColor', [
            'label' => __('plugins.themes.rumahJurnal.option.primaryColor.label'),
            'description' => __('plugins.themes.rumahJurnal.option.primaryColor.description'),
            'default' => '#2C366D',
        ]);

        $this->addOption('secondaryColor', 'FieldColor', [
            'label' => __('plugins.themes.rumahJurnal.option.secondaryColor.label'),
            'description' => __('plugins.themes.rumahJurnal.option.secondaryColor.description'),
            'default' => '#D2AA2A',
        ]);

        $this->addOption('heroTitle', 'FieldText', [
            'label' => __('plugins.themes.rumahJurnal.option.heroTitle.label'),
            'description' => __('plugins.themes.rumahJurnal.option.heroTitle.description'),
            'default' => 'Portal Publikasi Ilmiah & Riset Terbuka',
        ]);

        $this->addOption('heroDescription', 'FieldTextarea', [
            'label' => __('plugins.themes.rumahJurnal.option.heroDescription.label'),
            'description' => __('plugins.themes.rumahJurnal.option.heroDescription.description'),
            'default' => 'Menyajikan akses terbuka (Open Access) ke puluhan berkala ilmiah terindeks nasional (SINTA) dan internasional di lingkungan Universitas Islam Negeri Mahmud Yunus Batusangkar.',
        ]);

        // Built-in indexing logos option
        $builtinOptions = [];
        foreach (self::BUILTIN_INDEXING_LOGOS as $key => $logo) {
            $builtinOptions[] = [
                'value' => $key,
                'label' => $logo['name'],
            ];
        }

        $this->addOption('indexingLogos', 'FieldOptions', [
            'label' => __('plugins.themes.rumahJurnal.option.indexingLogos.label'),
            'description' => __('plugins.themes.rumahJurnal.option.indexingLogos.description'),
            'isOrderable' => true,
            'options' => $builtinOptions,
            'default' => array_keys(self::BUILTIN_INDEXING_LOGOS),
        ]);

        // Custom additional indexing logos option
        $this->addOption('customIndexingLogos', 'FieldTextarea', [
            'label' => __('plugins.themes.rumahJurnal.option.customIndexingLogos.label'),
            'description' => __('plugins.themes.rumahJurnal.option.customIndexingLogos.description'),
            'default' => '',
        ]);

        // Footer quick links option
        $defaultQuickLinks = "Beranda Portal | {\$baseUrl}\n"
            . "Daftar Jurnal Terindeks | {\$baseUrl}#daftar-jurnal\n"
            . "Kebijakan Publikasi | {\$baseUrl}/index.php/index/about\n"
            . "Login Pengguna | {\$baseUrl}/index.php/index/login\n"
            . "Pendaftaran Akun Penulis | {\$baseUrl}/index.php/index/user/register";

        $this->addOption('footerQuickLinks', 'FieldTextarea', [
            'label' => __('plugins.themes.rumahJurnal.option.footerQuickLinks.label'),
            'description' => __('plugins.themes.rumahJurnal.option.footerQuickLinks.description'),
            'default' => $defaultQuickLinks,
        ]);

        // Secretariat address option
        $defaultAddress = 'Gedung Pusat Kajian & Rumah Jurnal, UIN Mahmud Yunus Batusangkar, Sumatera Barat, Indonesia';

        $this->addOption('secretariatAddress', 'FieldTextarea', [
            'label' => __('plugins.themes.rumahJurnal.option.secretariatAddress.label'),
            'description' => __('plugins.themes.rumahJurnal.option.secretariatAddress.description'),
            'default' => $defaultAddress,
        ]);

        // Theme copyright & support information
        $this->addOption('themeCredits', 'FieldHTML', [
            'label' => __('plugins.themes.rumahJurnal.option.themeCredits.label'),
            'description' => __('plugins.themes.rumahJurnal.option.themeCredits.description'),
        ]);

        // Add Google Fonts: Plus Jakarta Sans & Outfit
        $this->addStyle(
            'googleFonts',
            'https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Outfit:wght@400;500;600;700;800&display=swap',
            ['baseUrl' => '']
        );

        // Add FontAwesome 6 Free CDN for rich icons
        $this->addStyle(
            'fontAwesome6',
            'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css',
            ['baseUrl' => '']
        );

        // Add custom portal CSS
        $this->addStyle('rumahJurnalPortal', 'styles/rumah-jurnal.css');

        // Inject dynamic theme color CSS variables
        $this->addStyle(
            'rumahJurnalDynamicColors',
            $this->getDynamicColorsCss(),
            ['inline' => true, 'priority' => PKPTemplateManager::STYLE_SEQUENCE_CORE]
        );

        // Hook into TemplateManager::display to supply enriched data for indexSite.tpl
        Hook::add('TemplateManager::display', [$this, 'enrichSiteIndexData']);
    }

    /**
     * Get primary color with fallback
     */
    public function getPrimaryColor(): string
    {
        $color = (string) $this->getOption('primaryColor');
        if (empty($color)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $color = $siteSettings['primaryColor'] ?? '';
        }
        if (empty($color)) {
            $color = '#2C366D';
        }
        return '#' . ltrim($color, '#');
    }

    /**
     * Get secondary / accent color with fallback
     */
    public function getSecondaryColor(): string
    {
        $color = (string) $this->getOption('secondaryColor');
        if (empty($color)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $color = $siteSettings['secondaryColor'] ?? '';
        }
        if (empty($color)) {
            $color = '#D2AA2A';
        }
        return '#' . ltrim($color, '#');
    }

    /**
     * Get hero headline title with fallback
     */
    public function getHeroTitle(): string
    {
        $title = (string) $this->getOption('heroTitle');
        if (empty($title)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $title = $siteSettings['heroTitle'] ?? '';
        }
        if (empty($title)) {
            $title = 'Portal Publikasi Ilmiah & Riset Terbuka';
        }
        return $title;
    }

    /**
     * Get hero description with fallback
     */
    public function getHeroDescription(): string
    {
        $desc = (string) $this->getOption('heroDescription');
        if (empty($desc)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $desc = $siteSettings['heroDescription'] ?? '';
        }
        if (empty($desc)) {
            $desc = 'Menyajikan akses terbuka (<span class="text-accent font-semibold">Open Access</span>) ke puluhan berkala ilmiah terindeks nasional (SINTA) dan internasional di lingkungan Universitas Islam Negeri Mahmud Yunus Batusangkar.';
        }
        return $desc;
    }

    /**
     * Adjust brightness of a hex color
     */
    public function adjustBrightness(string $hex, int $percent): string
    {
        $hex = ltrim($hex, '#');
        if (strlen($hex) === 3) {
            $hex = $hex[0] . $hex[0] . $hex[1] . $hex[1] . $hex[2] . $hex[2];
        }
        $r = hexdec(substr($hex, 0, 2));
        $g = hexdec(substr($hex, 2, 2));
        $b = hexdec(substr($hex, 4, 2));

        if ($percent > 0) {
            $r = (int) round($r + (255 - $r) * ($percent / 100));
            $g = (int) round($g + (255 - $g) * ($percent / 100));
            $b = (int) round($b + (255 - $b) * ($percent / 100));
        } else {
            $factor = (100 + $percent) / 100;
            $r = (int) round($r * $factor);
            $g = (int) round($g * $factor);
            $b = (int) round($b * $factor);
        }

        $r = max(0, min(255, $r));
        $g = max(0, min(255, $g));
        $b = max(0, min(255, $b));

        return sprintf('#%02x%02x%02x', $r, $g, $b);
    }

    /**
     * Generate 50..900 color scale
     */
    public function getColorScale(string $baseHex): array
    {
        return [
            '50' => $this->adjustBrightness($baseHex, 92),
            '100' => $this->adjustBrightness($baseHex, 80),
            '200' => $this->adjustBrightness($baseHex, 65),
            '300' => $this->adjustBrightness($baseHex, 45),
            '400' => $this->adjustBrightness($baseHex, 20),
            '500' => $baseHex,
            '600' => $this->adjustBrightness($baseHex, -15),
            '700' => $this->adjustBrightness($baseHex, -30),
            '800' => $this->adjustBrightness($baseHex, -50),
            '900' => $this->adjustBrightness($baseHex, -70),
        ];
    }

    /**
     * Generate dynamic CSS custom properties
     */
    public function getDynamicColorsCss(): string
    {
        $p = $this->getPrimaryColor();
        $s = $this->getSecondaryColor();
        $pScale = $this->getColorScale($p);
        $sScale = $this->getColorScale($s);

        return ":root {
  --rj-primary: {$p};
  --rj-primary-dark: {$pScale['900']};
  --rj-primary-900: {$pScale['900']};
  --rj-primary-800: {$pScale['800']};
  --rj-primary-700: {$pScale['700']};
  --rj-primary-600: {$pScale['600']};
  --rj-primary-500: {$p};
  --rj-primary-400: {$pScale['400']};
  --rj-primary-300: {$pScale['300']};
  --rj-primary-200: {$pScale['200']};
  --rj-primary-100: {$pScale['100']};
  --rj-primary-50: {$pScale['50']};
  --rj-gold: {$s};
  --rj-gold-hover: {$sScale['600']};
  --rj-gold-light: {$sScale['100']};
  --rj-gold-50: {$sScale['50']};
  --rj-gold-border: {$sScale['300']};
}";
    }

    /**
     * Inline Tailwind configuration script.
     */
    public function getTailwindConfigJs(): string
    {
        $p = $this->getPrimaryColor();
        $s = $this->getSecondaryColor();
        $pScale = $this->getColorScale($p);
        $sScale = $this->getColorScale($s);

        $primaryJson = json_encode(['DEFAULT' => $p] + $pScale);
        $accentJson = json_encode(['DEFAULT' => $s] + $sScale);

        return '
        if (typeof tailwind !== "undefined") {
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: ' . $primaryJson . ',
                            accent: ' . $accentJson . '
                        },
                        fontFamily: {
                            sans: ["Plus Jakarta Sans", "Inter", "system-ui", "sans-serif"],
                            display: ["Outfit", "Plus Jakarta Sans", "sans-serif"]
                        }
                    }
                }
            };
        }
        ';
    }

    /**
     * Enrich data passed to indexSite.tpl
     */
    public function enrichSiteIndexData(string $hookName, array $args): bool
    {
        $templateMgr = $args[0];
        $template = &$args[1];

        // Only run for frontend templates
        if (!is_string($template) || strpos($template, 'frontend/') !== 0) {
            return false;
        }

        try {
            $request = Application::get()->getRequest();
            $site = $request->getSite();

            // Resolve Brand Logo from Admin Site Settings (Site Settings -> Appearance -> Logo)
            $siteLogo = null;
            if ($site) {
                $allLogos = $site->getData('pageHeaderTitleImage');
                if (is_array($allLogos)) {
                    $currentLocale = Locale::getLocale();
                    if (!empty($allLogos[$currentLocale]['uploadName'])) {
                        $siteLogo = $allLogos[$currentLocale];
                    } elseif (!empty($allLogos[$site->getPrimaryLocale()]['uploadName'])) {
                        $siteLogo = $allLogos[$site->getPrimaryLocale()];
                    } else {
                        foreach ($allLogos as $loc => $locLogo) {
                            if (is_array($locLogo) && !empty($locLogo['uploadName'])) {
                                $siteLogo = $locLogo;
                                break;
                            }
                        }
                    }
                }
            }

            // Direct DB fallback if not resolved via DataObject
            if (empty($siteLogo) || empty($siteLogo['uploadName'])) {
                $logoRows = DB::table('site_settings')
                    ->where('setting_name', 'pageHeaderTitleImage')
                    ->whereNotNull('setting_value')
                    ->get();
                foreach ($logoRows as $row) {
                    $decoded = json_decode($row->setting_value, true);
                    if (is_array($decoded) && !empty($decoded['uploadName'])) {
                        $siteLogo = $decoded;
                        break;
                    }
                }
            }

            $siteLogoUrl = null;
            $siteLogoAlt = null;
            $isWideLogo = false;
            if (!empty($siteLogo) && !empty($siteLogo['uploadName'])) {
                $publicFileManager = new PublicFileManager();
                $siteLogoUrl = $request->getBaseUrl() . '/' . $publicFileManager->getSiteFilesPath() . '/' . rawurlencode($siteLogo['uploadName']);
                $siteLogoAlt = !empty($siteLogo['altText']) ? $siteLogo['altText'] : ($site ? $site->getLocalizedTitle() : 'Rumah Jurnal');
                $width = (int) ($siteLogo['width'] ?? 0);
                $height = (int) ($siteLogo['height'] ?? 0);
                if ($height > 0 && ($width / $height) > 2.0) {
                    $isWideLogo = true;
                }
            }

            $primary = $this->getPrimaryColor();
            $secondary = $this->getSecondaryColor();
            $heroTitle = $this->getHeroTitle();
            $heroDescription = $this->getHeroDescription();

            // Resolve Page Footer from OJS Site Settings
            $pageFooter = $templateMgr->getTemplateVars('pageFooter');
            if (empty($pageFooter) && $site) {
                $pageFooter = $site->getLocalizedData('pageFooter');
                if (empty($pageFooter)) {
                    $allFooters = $site->getData('pageFooter');
                    if (is_array($allFooters)) {
                        $primaryLocale = $site->getPrimaryLocale();
                        $pageFooter = $allFooters[$primaryLocale] ?? reset($allFooters);
                    } elseif (is_string($allFooters)) {
                        $pageFooter = $allFooters;
                    }
                }
            }
            if (empty($pageFooter)) {
                $footerRow = DB::table('site_settings')
                    ->where('setting_name', 'pageFooter')
                    ->whereNotNull('setting_value')
                    ->first();
                if ($footerRow && !empty($footerRow->setting_value)) {
                    $pageFooter = $footerRow->setting_value;
                }
            }

            // Determine if logged in user is Site Administrator
            $currentUser = $request->getUser();
            $isSiteAdmin = false;
            if ($currentUser) {
                $isSiteAdmin = Validation::isSiteAdmin()
                    || $currentUser->hasRole([Role::ROLE_ID_SITE_ADMIN], PKPApplication::SITE_CONTEXT_ID);
            }

            $assignData = [
                'pageFooter' => $pageFooter,
                'heroTitle' => $heroTitle,
                'heroDescription' => $heroDescription,
                'siteLogoUrl' => $siteLogoUrl,
                'siteLogoAlt' => $siteLogoAlt,
                'siteLogoIsWide' => $isWideLogo,
                'siteTitle' => $site ? $site->getLocalizedTitle() : 'Rumah Jurnal',
                'themePrimaryColor' => $primary,
                'themeSecondaryColor' => $secondary,
                'themePrimaryScale' => $this->getColorScale($primary),
                'themeSecondaryScale' => $this->getColorScale($secondary),
                'isSiteAdmin' => $isSiteAdmin,
                'principalContactEmail' => $this->getPrincipalContactEmail(),
                'footerQuickLinks' => $this->getFooterQuickLinks($request->getBaseUrl()),
                'secretariatAddress' => $this->getSecretariatAddress(),
                'siteUrl' => $request->getBaseUrl(),
                'languageToggle' => $this->getLanguageToggleData(),
            ];

            // Only query and enrich journals on the portal site index page
            if ($template === 'frontend/pages/indexSite.tpl') {
                $assignData['indexingLogos'] = $this->getActiveIndexingLogos($request->getBaseUrl());
                $journals = $templateMgr->getTemplateVars('journals');

                if (is_array($journals)) {
                    // Fetch counts for articles & issues efficiently in bulk
                    $articleCounts = DB::table('submissions')
                        ->select('context_id', DB::raw('count(*) as count'))
                        ->where('status', 3)
                        ->groupBy('context_id')
                        ->pluck('count', 'context_id');

                    $issueCounts = DB::table('issues')
                        ->select('journal_id', DB::raw('count(*) as count'))
                        ->where('published', 1)
                        ->groupBy('journal_id')
                        ->pluck('count', 'journal_id');

                    $journalFilesPath = $templateMgr->getTemplateVars('journalFilesPath');
                    $enrichedJournals = [];
                    $totalArticlesCount = 0;
                    $totalIssuesCount = 0;
                    $sintaCounts = 0;

                    foreach ($journals as $journal) {
                        $jId = $journal->getId();
                        $path = $journal->getPath();
                        $name = $journal->getLocalizedName();
                        $rawDesc = (string) $journal->getLocalizedDescription();
                        
                        // Clean up narrative text by removing tables and formatting tags
                        $narrativeDesc = preg_replace('/<table[\s\S]*?<\/table>/i', '', $rawDesc);
                        $cleanDesc = trim(strip_tags($narrativeDesc));
                        if (empty($cleanDesc)) {
                            $cleanDesc = trim(strip_tags($rawDesc));
                        }
                        $cleanDesc = preg_replace('/\s+/', ' ', $cleanDesc);
                        if (mb_strlen($cleanDesc) > 175) {
                            $cleanDesc = mb_substr($cleanDesc, 0, 175) . '...';
                        }

                        $thumb = $journal->getLocalizedData('journalThumbnail');
                        $thumbUrl = $thumb && !empty($thumb['uploadName'])
                            ? $journalFilesPath . $jId . '/' . rawurlencode($thumb['uploadName'])
                            : null;

                        $pIssn = (string) ($journal->getData('printIssn') ?? '');
                        $eIssn = (string) ($journal->getData('onlineIssn') ?? '');

                        if (trim($pIssn) === '-') $pIssn = '';
                        if (trim($eIssn) === '-') $eIssn = '';

                        // Detect Sinta from description or metadata
                        $sintaLevel = null;
                        if (preg_match('/sinta\s*([1-6])/i', $rawDesc, $matches)) {
                            $sintaLevel = 'SINTA ' . $matches[1];
                            $sintaCounts++;
                        } elseif (preg_match('/accredited\s*sinta|sinta\.png|sinta\.kemdikbud|sinta\.kemdiktisaintek|terakreditasi\s*sinta/i', $rawDesc)) {
                            $sintaLevel = 'SINTA';
                            $sintaCounts++;
                        }

                        // Detect Focus/Discipline Category
                        $category = $this->detectCategory($name, $rawDesc, $path);

                        $artCount = (int) ($articleCounts[$jId] ?? 0);
                        $issCount = (int) ($issueCounts[$jId] ?? 0);
                        $totalArticlesCount += $artCount;
                        $totalIssuesCount += $issCount;

                        $homeUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path);
                        $currentIssueUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path, 'issue', 'current');
                        $submitUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path, 'about', 'submissions');

                        $cleanLetters = preg_replace('/[^a-zA-Z]/', '', $name);
                        $initial = strtoupper(substr($cleanLetters ?: $path, 0, 2));

                        $enrichedJournals[] = [
                            'id' => $jId,
                            'path' => $path,
                            'name' => $name,
                            'cleanDescription' => $cleanDesc,
                            'thumbnailUrl' => $thumbUrl,
                            'printIssn' => $pIssn,
                            'onlineIssn' => $eIssn,
                            'sintaLevel' => $sintaLevel,
                            'category' => $category,
                            'articleCount' => $artCount,
                            'issueCount' => $issCount,
                            'homeUrl' => $homeUrl,
                            'currentIssueUrl' => $currentIssueUrl,
                            'submitUrl' => $submitUrl,
                            'initial' => $initial,
                        ];
                    }

                    $assignData['enrichedJournals'] = $enrichedJournals;
                    $assignData['journalsJson'] = json_encode($enrichedJournals, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_AMP | JSON_HEX_QUOT);
                    $assignData['portalTotalJournals'] = count($enrichedJournals);
                    $assignData['portalTotalArticles'] = $totalArticlesCount;
                    $assignData['portalTotalIssues'] = $totalIssuesCount;
                    $assignData['portalTotalSinta'] = $sintaCounts;
                }
            }

            $templateMgr->assign($assignData);
        } catch (\Throwable $e) {
            error_log('RumahJurnalThemePlugin::enrichSiteIndexData error: ' . $e->getMessage() . ' at line ' . $e->getLine());
        }

        return false;
    }

    /**
     * Get active accreditation & indexing logos for indexSite.tpl
     */
    public function getActiveIndexingLogos(string $baseUrl): array
    {
        $enabled = $this->getOption('indexingLogos');
        if (!is_array($enabled)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            if (isset($siteSettings['indexingLogos'])) {
                $val = $siteSettings['indexingLogos'];
                $enabled = is_array($val) ? $val : json_decode((string) $val, true);
            }
        }

        // If never set before in DB, default to all built-in logos
        if (!is_array($enabled)) {
            $enabled = array_keys(self::BUILTIN_INDEXING_LOGOS);
        }

        $logos = [];
        $imageBasePath = rtrim($baseUrl, '/') . '/plugins/themes/rumahJurnal/images/';

        // Add enabled built-in logos in the order specified by $enabled
        foreach ($enabled as $key) {
            if (isset(self::BUILTIN_INDEXING_LOGOS[$key])) {
                $item = self::BUILTIN_INDEXING_LOGOS[$key];
                $logos[] = [
                    'id' => $key,
                    'name' => $item['name'],
                    'title' => $item['title'] ?? $item['name'],
                    'image' => $imageBasePath . $item['file'],
                    'url' => $item['url'] ?? '',
                ];
            }
        }

        // Parse custom indexing logos
        $customRaw = (string) $this->getOption('customIndexingLogos');
        if (empty($customRaw)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $customRaw = $siteSettings['customIndexingLogos'] ?? '';
        }

        if (!empty($customRaw)) {
            $lines = preg_split('/[\r\n]+/', (string) $customRaw);
            foreach ($lines as $line) {
                $line = trim($line);
                if ($line === '' || str_starts_with($line, '#')) {
                    continue;
                }
                $parts = array_map('trim', explode('|', $line));
                $name = $parts[0] ?? '';
                $image = $parts[1] ?? '';
                $url = $parts[2] ?? '';

                if ($name === '' || $image === '') {
                    continue;
                }

                // If image is a local filename rather than full URL, prepend theme images directory
                if (!preg_match('/^(https?:\/\/|\/\/|\/)/i', $image)) {
                    $image = $imageBasePath . $image;
                }

                $logos[] = [
                    'id' => 'custom_' . substr(md5($line), 0, 8),
                    'name' => $name,
                    'title' => $name,
                    'image' => $image,
                    'url' => $url,
                ];
            }
        }

        return $logos;
    }

    /**
     * Get Principal Contact Email with multi-level fallback
     */
    public function getPrincipalContactEmail(): string
    {
        try {
            $request = Application::get()->getRequest();
            $context = $request->getContext();
            $site = $request->getSite();

            $contactEmail = null;
            if ($context) {
                $contactEmail = $context->getLocalizedData('contactEmail') ?: $context->getData('contactEmail');
            }
            if (empty($contactEmail) && $site) {
                $contactEmail = $site->getLocalizedData('contactEmail') ?: $site->getData('contactEmail');
            }

            // If multilingual array, resolve best locale
            if (is_array($contactEmail)) {
                $locale = Locale::getLocale();
                if (!empty($contactEmail[$locale])) {
                    $contactEmail = $contactEmail[$locale];
                } elseif ($site && !empty($contactEmail[$site->getPrimaryLocale()])) {
                    $contactEmail = $contactEmail[$site->getPrimaryLocale()];
                } else {
                    $contactEmail = reset($contactEmail);
                }
            }

            if (empty($contactEmail)) {
                $row = DB::table('site_settings')
                    ->where('setting_name', 'contactEmail')
                    ->whereNotNull('setting_value')
                    ->where('setting_value', '<>', '')
                    ->first();
                if ($row) {
                    $contactEmail = $row->setting_value;
                }
            }

            if (empty($contactEmail) || !is_string($contactEmail)) {
                $contactEmail = 'adminojs@uinmybatusangkar.ac.id';
            }

            return (string) $contactEmail;
        } catch (\Throwable $e) {
            return 'adminojs@uinmybatusangkar.ac.id';
        }
    }

    /**
     * Get active quick links for footer
     */
    public function getFooterQuickLinks(string $baseUrl): array
    {
        $raw = (string) $this->getOption('footerQuickLinks');
        if (empty($raw)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $raw = $siteSettings['footerQuickLinks'] ?? '';
        }

        if (empty($raw)) {
            $raw = "Beranda Portal | {\$baseUrl}\n"
                . "Daftar Jurnal Terindeks | {\$baseUrl}#daftar-jurnal\n"
                . "Kebijakan Publikasi | {\$baseUrl}/index.php/index/about\n"
                . "Login Pengguna | {\$baseUrl}/index.php/index/login\n"
                . "Pendaftaran Akun Penulis | {\$baseUrl}/index.php/index/user/register";
        }

        $lines = preg_split('/[\r\n]+/', (string) $raw);
        $links = [];
        $cleanBaseUrl = rtrim($baseUrl, '/');

        // Mapping for translating the standard default titles when viewing in another language
        $defaultTranslations = [
            'Beranda Portal' => __('plugins.themes.rumahJurnal.footer.home'),
            'Daftar Jurnal Terindeks' => __('plugins.themes.rumahJurnal.footer.indexedJournals'),
            'Kebijakan Publikasi' => __('plugins.themes.rumahJurnal.footer.about'),
            'Login Pengguna' => __('plugins.themes.rumahJurnal.footer.login'),
            'Pendaftaran Akun Penulis' => __('plugins.themes.rumahJurnal.footer.register'),
        ];

        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '' || str_starts_with($line, '#')) {
                continue;
            }
            $parts = array_map('trim', explode('|', $line, 2));
            $title = $parts[0] ?? '';
            $url = $parts[1] ?? '';
            if ($title === '') {
                continue;
            }
            if ($url === '') {
                $url = '#';
            }
            // Support variable replacements like {$baseUrl} or {baseUrl}
            $url = str_replace(['{$baseUrl}', '{baseUrl}'], $cleanBaseUrl, $url);

            if (isset($defaultTranslations[$title])) {
                $title = $defaultTranslations[$title];
            }

            $links[] = [
                'title' => $title,
                'url' => $url,
            ];
        }

        return $links;
    }

    /**
     * Get Secretariat Address with fallback
     */
    public function getSecretariatAddress(): string
    {
        $address = (string) $this->getOption('secretariatAddress');
        if (empty($address)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $address = $siteSettings['secretariatAddress'] ?? '';
        }

        if (empty($address)) {
            $address = 'Gedung Pusat Kajian & Rumah Jurnal, UIN Mahmud Yunus Batusangkar, Sumatera Barat, Indonesia';
        }

        // Translate default address if viewing in another language
        if ($address === 'Gedung Pusat Kajian & Rumah Jurnal, UIN Mahmud Yunus Batusangkar, Sumatera Barat, Indonesia') {
            $address = __('plugins.themes.rumahJurnal.footer.defaultAddress');
        }

        return $address;
    }

    /**
     * Get formatted language list for language switcher dropdown
     */
    public function getLanguageToggleData(): array
    {
        try {
            $request = Application::get()->getRequest();
            $context = $request->getContext();
            $site = $request->getSite();

            $supportedLocales = isset($context)
                ? $context->getSupportedLocales()
                : ($site ? $site->getSupportedLocales() : []);

            if (empty($supportedLocales) || !is_array($supportedLocales)) {
                $supportedLocales = ['id', 'en'];
            }

            $currentLocale = (string) Locale::getLocale();
            $serverName = $_SERVER['SERVER_NAME'] ?? '';
            $requestUri = $_SERVER['REQUEST_URI'] ?? '';
            $source = $serverName . $requestUri;

            try {
                $nativeNames = Locale::getFormattedDisplayNames($supportedLocales, Locale::getLocales(), \PKP\i18n\LocaleMetadata::LANGUAGE_LOCALE_ONLY);
            } catch (\Throwable $e) {
                $nativeNames = [];
            }

            $flagSvgs = [
                'id' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="1" fill="#E70011"/><rect y="1" width="3" height="1" fill="#FFFFFF"/></svg>',
                'id_ID' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="1" fill="#E70011"/><rect y="1" width="3" height="1" fill="#FFFFFF"/></svg>',
                'en' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 600 300"><rect width="600" height="300" fill="#012169"/><path d="M0,0 L600,300 M600,0 L0,300" stroke="#ffffff" stroke-width="60"/><path d="M0,0 L300,150 M600,300 L300,150" stroke="#c8102e" stroke-width="40"/><path d="M600,0 L300,150 M0,300 L300,150" stroke="#c8102e" stroke-width="40"/><path d="M300,0 V300 M0,150 H600" stroke="#ffffff" stroke-width="100"/><path d="M300,0 V300 M0,150 H600" stroke="#c8102e" stroke-width="60"/></svg>',
                'en_US' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 600 300"><rect width="600" height="300" fill="#012169"/><path d="M0,0 L600,300 M600,0 L0,300" stroke="#ffffff" stroke-width="60"/><path d="M0,0 L300,150 M600,300 L300,150" stroke="#c8102e" stroke-width="40"/><path d="M600,0 L300,150 M0,300 L300,150" stroke="#c8102e" stroke-width="40"/><path d="M300,0 V300 M0,150 H600" stroke="#ffffff" stroke-width="100"/><path d="M300,0 V300 M0,150 H600" stroke="#c8102e" stroke-width="60"/></svg>',
                'ar' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="2" fill="#006C35"/><path d="M1.0,0.6 A0.4,0.4 0 1 0 1.8,1.4 A0.32,0.32 0 1 1 1.0,0.6 Z" fill="#ffffff"/><polygon points="1.6,0.85 1.67,0.97 1.8,0.97 1.7,1.05 1.73,1.17 1.6,1.1 1.47,1.17 1.5,1.05 1.4,0.97 1.53,0.97" fill="#ffffff"/></svg>',
                'ar_IQ' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="2" fill="#006C35"/><path d="M1.0,0.6 A0.4,0.4 0 1 0 1.8,1.4 A0.32,0.32 0 1 1 1.0,0.6 Z" fill="#ffffff"/><polygon points="1.6,0.85 1.67,0.97 1.8,0.97 1.7,1.05 1.73,1.17 1.6,1.1 1.47,1.17 1.5,1.05 1.4,0.97 1.53,0.97" fill="#ffffff"/></svg>',
                'ms' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 14 7"><rect width="14" height="7" fill="#cc0000"/><rect y="0.5" width="14" height="0.5" fill="#ffffff"/><rect y="1.5" width="14" height="0.5" fill="#ffffff"/><rect y="2.5" width="14" height="0.5" fill="#ffffff"/><rect y="3.5" width="14" height="0.5" fill="#ffffff"/><rect y="4.5" width="14" height="0.5" fill="#ffffff"/><rect y="5.5" width="14" height="0.5" fill="#ffffff"/><rect width="7" height="4" fill="#000066"/><circle cx="3" cy="2" r="1.3" fill="#ffcc00"/><circle cx="3.4" cy="2" r="1.1" fill="#000066"/><polygon points="4.6,2 4.0,2.2 4.4,2.7 3.8,2.5 3.8,3.2 3.4,2.7 3.0,3.1 3.2,2.5 2.6,2.5 3.0,2.1 2.7,1.6 3.2,1.8 3.5,1.2 3.7,1.8" fill="#ffcc00"/></svg>',
                'fr' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="1" height="2" fill="#002395"/><rect x="1" width="1" height="2" fill="#ffffff"/><rect x="2" width="1" height="2" fill="#ed2939"/></svg>',
                'es' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="2" fill="#AA151B"/><rect y="0.5" width="3" height="1" fill="#F1BF00"/></svg>',
                'de' => '<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 5 3"><rect width="5" height="1" fill="#000000"/><rect y="1" width="5" height="1" fill="#DD0000"/><rect y="2" width="5" height="1" fill="#FFCE00"/></svg>',
            ];

            $names = [
                'id' => 'Bahasa Indonesia',
                'id_ID' => 'Bahasa Indonesia',
                'en' => 'English',
                'en_US' => 'English',
                'ar' => 'العربية',
                'ar_IQ' => 'العربية',
                'ms' => 'Bahasa Melayu',
                'fr' => 'Français',
                'es' => 'Español',
                'de' => 'Deutsch',
            ];

            $shortCodes = [
                'id' => 'ID',
                'id_ID' => 'ID',
                'en' => 'EN',
                'en_US' => 'EN',
                'ar' => 'AR',
                'ar_IQ' => 'AR',
                'ms' => 'MS',
                'fr' => 'FR',
                'es' => 'ES',
                'de' => 'DE',
            ];

            $languages = [];
            $currentLanguage = null;

            foreach ($supportedLocales as $locKey) {
                $prefix = substr($locKey, 0, 2);
                $name = $nativeNames[$locKey] ?? ($names[$locKey] ?? ($names[$prefix] ?? $locKey));
                $code = $shortCodes[$locKey] ?? ($shortCodes[$prefix] ?? strtoupper($prefix));
                $flag = $flagSvgs[$locKey] ?? ($flagSvgs[$prefix] ?? ('<svg class="w-5 h-3.5 rounded-xs shadow-xs inline-block object-cover flex-shrink-0 border border-black/10" viewBox="0 0 3 2"><rect width="3" height="2" fill="#2C366D"/><text x="1.5" y="1.4" font-size="0.9" font-weight="bold" fill="#ffffff" text-anchor="middle">' . htmlspecialchars($code) . '</text></svg>'));
                $isCurrent = ($locKey === $currentLocale || $prefix === substr($currentLocale, 0, 2));

                $url = '';
                try {
                    $dispatcher = $request->getDispatcher();
                    if ($dispatcher) {
                        $url = $dispatcher->url(
                            $request,
                            PKPApplication::ROUTE_PAGE,
                            null,
                            'user',
                            'setLocale',
                            [$locKey],
                            !empty($source) ? ['source' => $source] : []
                        );
                    }
                } catch (\Throwable $e) {
                    $url = '';
                }

                $langItem = [
                    'key' => $locKey,
                    'name' => $name,
                    'code' => $code,
                    'flag' => $flag,
                    'url' => $url,
                    'isCurrent' => $isCurrent,
                ];

                $languages[] = $langItem;

                if ($isCurrent) {
                    $currentLanguage = $langItem;
                }
            }

            if (!$currentLanguage && !empty($languages)) {
                $currentLanguage = $languages[0];
                $languages[0]['isCurrent'] = true;
            }

            return [
                'languages' => $languages,
                'currentLanguage' => $currentLanguage,
                'hasMultipleLanguages' => count($languages) > 1,
            ];
        } catch (\Throwable $e) {
            return [
                'languages' => [],
                'currentLanguage' => null,
                'hasMultipleLanguages' => false,
            ];
        }
    }

    /**
     * Categorize journal based on title, description, or path keywords
     */
    private function detectCategory(string $name, string $desc, string $path): string
    {
        $titlePath = strtolower($name . ' ' . $path);
        $text = strtolower($name . ' ' . $desc . ' ' . $path);

        // 1. Direct path/title matching
        if (preg_match('/sainstek|math|bansi|komputer|informatika|jamik/i', $titlePath)) {
            return 'Sains & Teknologi';
        }
        if (preg_match('/syariah|syari\'ah|hukum|law|ushuliy|juris|jisrah/i', $titlePath)) {
            return 'Syariah & Hukum';
        }
        if (preg_match('/ekonomi|bisnis|banking|perbankan|zakat|waqf|tourism|tamwil|mabis|zawa|jaksya|albank|al-bank|intifaq|imara/i', $titlePath)) {
            return 'Ekonomi & Bisnis Islam';
        }
        if (preg_match('/tarbiyah|pendidikan|education|keguruan|ta\'dib|edusainstika|ijecer|manapi|pilar/i', $titlePath)) {
            return 'Pendidikan & Tarbiyah';
        }
        if (preg_match('/bahasa|linguistik|arabic|english|lughawiyah|alsinah|linguavision/i', $titlePath)) {
            return 'Bahasa & Sastra';
        }
        if (preg_match('/komunikasi|penyiaran|media|psikologi|konseling|dakwah|sosial|indev|kinema|batanang|semantik|kaaffah|icon|alfuad|istinarah/i', $titlePath)) {
            return 'Sosial & Humaniora';
        }
        if (preg_match('/proceeding|konferensi/i', $titlePath)) {
            return 'Prosiding & Konferensi';
        }

        // 2. Fallback to full description
        if (preg_match('/sains|teknologi|natural science|mathematics|chemistry|biology/i', $text)) {
            return 'Sains & Teknologi';
        }
        if (preg_match('/syariah|syari\'ah|hukum|law/i', $text)) {
            return 'Syariah & Hukum';
        }
        if (preg_match('/ekonomi|bisnis|economic/i', $text)) {
            return 'Ekonomi & Bisnis Islam';
        }
        if (preg_match('/pendidikan|education|tarbiyah/i', $text)) {
            return 'Pendidikan & Tarbiyah';
        }
        if (preg_match('/language|linguistics|bahasa/i', $text)) {
            return 'Bahasa & Sastra';
        }
        if (preg_match('/sosial|humaniora|psychology|dakwah/i', $text)) {
            return 'Sosial & Humaniora';
        }

        return 'Keislaman & Multidisiplin';
    }

    /**
     * Get display name
     */
    public function getDisplayName()
    {
        return __('plugins.themes.rumahJurnal.name');
    }

    /**
     * Get description
     */
    public function getDescription()
    {
        return __('plugins.themes.rumahJurnal.description');
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\rumahJurnal\RumahJurnalThemePlugin', '\RumahJurnalThemePlugin');
}