unit XomCntrLib;

interface

uses OpenGLx, SysUtils, Classes, Windows, Contnrs, ComCtrls, StdCtrls, ExtCtrls,
  Graphics, Valedit, XTrackPanel, Math, CrystalDxt;

type

  Tver    = array[0..2] of GLfloat;
  Color4d = array[0..3] of GLfloat;

  AVer    = array of TVer;
  Aval    = array of GLfloat;
  AAval   = array of Aval;
  TFace   = array[0..3] of Word;
  IFace   = array of Word;
  AFace   = array of TFace;
  TFace3  = array[0..2] of Word;
  AFace3  = array of TFace3;
  Tpnt    = array[0..1] of GLfloat;
  ATCoord = array of Tpnt;
  TUColor = array[0..3] of Byte;
  AUColor = array of TUColor;
  AFColor = array of Color4d;
  ATexures  = array of Integer;
  Tvector = record
    X, Y, Z: GLfloat;
  end;

  TBox = record
    Xmin, Ymin, Zmin: GLfloat;
    Xmax, Ymax, Zmax: GLfloat;
  end;


  TMatrix = array[1..4, 1..4] of GLfloat;


  TgaHead = record
    zero: Word;
    typeTGA: Word;
    zero2: Longword;
    zero3: Longword;
    Width: Word;
    Height: Word;
    ColorBit: Word;
  end;

  TRGBA = record
    b, g, r, a: Byte;
  end;
  ARGBA  = array [0..1] of TRGBA;
  PARGBA = ^ARGBA;

  TRGB = record
    b, g, r: Byte;
  end;
  ARGB  = array [0..1] of TRGB;
  PARGB = ^ARGB;

  AB  = array [0..1] of Byte;
  PAB = ^AB;

  XEnumStrings = array [0..1] of string;
  PXEnumStrings = ^XEnumStrings;

  XValTypes = (XString,XFloat,XFFloat,XVector,XVectorR,XVector4,XSBound,
        XMatrix3,XMatrix4,XInt,XListInt,XBool,XUint,
        XBColor,XFColor,XColor,XCode,XPoint,XByte,XEnum,XEnumByte,XIndex,X4Char,XText);
  XTypes = (XNone,
    AIParametersContainer,
    AcceptCancelButtonDesc,
    AchievementsProgressContainer,
    AssistedShotTweaks,
    BaseWeaponContainer,
    BrickBuildingCtr,
    BrickBuildingList,
    BrickLinkage,
    BuildingGlobalContainer,
    BuildingSpecificContainer,
    CachedLeaderBoardWrite,
    Campaign,
    CampaignCollective,
    CampaignData,
    ChaseCameraPropertiesContainer,
    ChatMessagesContainer,
    ChatMessagesWindowDetails,
    CheckBoxDesc,
    ComboControlDesc,
    ControlSetupDesc,
    CrateDataContainer,
    CreditsFMVs,
    DamageStatsContainer,
    DetailEntityStore,
    EFMV_AnimateCustomHudGraphicEventContainer,
    EFMV_AnimateDetailEventContainer,
    EFMV_CastActorEventContainer,
    EFMV_CommentEventContainer,
    EFMV_ClearAccessoryEventContainer,
    EFMV_CreateBordersEventContainer,
    EFMV_CreateCustomHudGraphicEventContainer,
    EFMV_CreateEmitterEventContainer,
    EFMV_CreateExplosionEventContainer,
    EFMV_CreateWXBriefingBoxEventContainer,
    EFMV_CutCameraEventContainer,
    EFMV_DeleteBordersEventContainer,
    EFMV_DeleteCustomHudGraphicEventContainer,
    EFMV_DeleteEmitterEventContainer,
    EFMV_DeleteLandframeEventContainer,
    EFMV_FailureCommentEventContainer,
    EFMV_MovieContainer,
    EFMV_PathCameraEventContainer,
    EFMV_PlayAnimationEventContainer,
    EFMV_ShakeCameraEventContainer,
    EFMV_SpawnAccessoryEventContainer,
    EFMV_SpawnParticleEventContainer,
    EFMV_SpawnWormEventContainer,
    EFMV_StopAnimationEventContainer,
    EFMV_StopEventContainer,
    EFMV_ThreatenWormEventContainer,
    EFMV_TimedPathCameraEventContainer,
    EFMV_TrackContainer,
    EFMV_TriggerSoundEffectEventContainer,
    EFMV_TriggerSpeechEventContainer,
    EFMV_UnspawnWormEventContainer,
    EFMV_WormBaseEventContainer,
    EFMV_WormEmoteEventContainer,
    EFMV_WormGestureAtEventContainer,
    EFMV_WormLookAtEventContainer,
    EffectDetailsContainer,
    FlagDataContainer,
    FlagLockIdentifier,
    FlyCameraPropertiesContainer,
    FlyingPayloadWeaponPropertiesContainer,
    FMVSubTiles,
    FMVTextLine,
    FrameBoxDesc,
    GSNetworkGameList,
    GSProfile,
    GSProfileList,
    GSRoomList,
    GSTeamList,
    GameInitData,
    GraphicEqualiserDesc,
    GunWeaponPropertiesContainer,
    HighScoreData,
    HomingPayloadWeaponPropertiesContainer,
    InputDetailsContainer,
    InputEventMappingContainer,
    InputMappingDetails,
    IntegerArray,
    JumpingPayloadWeaponPropertiesContainer,
    LandFrameStore,
    LandscapeBoxDesc,
    LensFlareContainer,
    LensFlareElementContainer,
    LevelDetails,
    LevelLock,
    ListBoxData,
    ListBoxIconColumn,
    ListBoxStringColumn,
    ListControlDesc,
    ListHeaderControlDesc,
    Lock,
    LockedBitmapArray,
    LockedBitmapDesc,
    LockedContainer,
    MeleeWeaponPropertiesContainer,
    MenuButtonDesc,
    MenuDescription,
    MineFactoryContainer,
    Mission,
    Movie,
    MovieLock,
    MultiStateButtonDesc,
    MultiStateTextButtonDesc,
    OccludingCameraPropertiesContainer,
    PC_LandChunk,
    PC_LandFrame,
    ParticleEmitterContainer,
    ParticleMeshNamesContainer,
    PayloadWeaponPropertiesContainer,
    PercentButtonDesc,
    PictureViewDesc,
    PlayerList,
    ProfileAchievementsContainer,
    SavedLevel,
    SavedLevelCollective,
    SchemeColective,
    SchemeCollective,
    SchemeData,
    SchemeDataContainer,
    ShotStatsCollective,
    SentryGunWeaponPropertiesContainer,
    SimpleCameraContainer,
    SoundBankColective,
    SoundBankCollective,
    SoundBankData,
    StatsContainer,
    StoreWeaponFactory,
    StoredStatsCollective,
    StoredTeamData,
    StringQueue,
    StringStack,
    TeamAwardsContainer,
    TeamCareerStats,
    TeamDataColective,
    TeamDataCollective,
    TeamDataContainer,
    TeamPersistDataContainer,
    TextBoxDesc,
    TextButtonDesc,
    TextEditBoxDesc,
    TitleTextDesc,
    TrackCameraContainer,
    TriggerDataContainer,
    W3DLumpBoundBox,
    W3DLumpConnector,
    W3DTemplate,
    W3DTemplateSet,
    WXFE_AttachmentOffsets,
    WXFE_BriefingDesc,
    WXFE_ButtonHelpDesc,
    WXFE_FlagObjectDesc,
    WXFE_GalleryImageDesc,
    WXFE_GalleryThumbDesc,
    WXFE_GapColumns,
    WXFE_GetControllerInputDesc,
    WXFE_HighlightIconColumns,
    WXFE_HowToPlayTextBoxDesc,
    WXFE_IconColumns,    
    WXFE_ImageViewDesc,
    WXFE_InputDesc,
    WXFE_LandscapeBoxDesc,
    WXFE_LevelDetails,
    WXFE_ListBoxContents,
    WXFE_ListBoxRows,
    WXFE_ListControlDesc,
    WXFE_ListDetailDesc,
    WXFE_MenuButtonDesc,
    WXFE_MenuDescription,
    WXFE_MeshObjectDesc,
    WXFE_MeshObjectParticleDesc,
    WXFE_NewsFeedScrollingTextDesc,
    WXFE_PlayerRepresentationObjectDesc,
    WXFE_PowerColumns,
    WXFE_ScrollingTextDesc,
    WXFE_ShopDesc,
    WXFE_SoftwareKeyBoardData,
    WXFE_SoftwareKeyBoardDesc,
    WXFE_StringColumns,
    WXFE_StringTableColumns,
    WXFE_TextBoxDesc,
    WXFE_TextEditBoxDesc,
    WXFE_TitleControlDesc,
    WXFE_TrophyCabinetDesc,
    WXFE_TrophyDesc,
    WXFE_UnlockableItem,
    WXFE_UnlockableItemSet,
    WXFE_WeaponFactoryMeshDesc,
    WXFE_WormAttachments,
    WXFE_WormDesc,
    WXFE_WormPotControlDesc,
    WXLumpBoundBox,
    WXLumpConnector,
    WXTemplate,
    WXTemplateSet,
    WaterPlaneTweaks,
    WeaponControlDesc,
    WeaponDataCtr,
    WeaponDelays,
    WeaponFactoryAirstrikeCostContainer,
    WeaponFactoryCollective,
    WeaponFactoryContainer,
    WeaponFactoryLanchedCostContainer,
    WeaponFactoryThrownCostContainer,
    WeaponInventory,
    WeaponSettingsData,
    WormCareerStats,
    WormDataContainer,
    WormPotContainer,
    WormPotControlDesc,
    WormStatsContainer,
    WormapediaCollective,
    WormapediaDetails,
    WormpaediaColective,
    WormpaediaDetails,
    XAlphaTest,
    XAnimChannel,
    XAnimClipLibrary,
    XAnimInfo,
    XAttrPass,
    XBasicEmitter,
    XBillboardSpriteSet,
    XBinModifier,
    XBinSelector,
    XBinormal3fSet,
    XBitmapDescriptor,
    XBlendModeGL,
    XBone,
    XBrickDetails,
    XBrickGeometry,
    XBrickIndexSet,
    XBuildingShape,
    XChildSelector,
    XCollisionData,
    XCollisionGeometry,
    XColor4ubSet,
    XColorResourceDetails,
    XConstColorSet,
    XContainerResourceDetails,
    XCoord3fSet,
    XCoord3sSet_1uScale,
    XCullFace,
    XCustomDescriptor,
    XCustomShader,
    XDataBank,
    XDataFloat,
    XDataMatrix4f,
    XDataStreamDeclarator,
    XDataVector4f,
    XDepthTest,
    XDetailObjectsData,
    XDetailSwitch,
    XDirectMusicDescriptor,
    XEnvironmentMapShader,
    XExpandedAnimInfo,
    XExportAttributeString,
    XFloatResourceDetails,
    XFortsExportedData,
    XGraphSet,
    XGroup,
    XImage,
    XIndexSet,
    XIndexSet8,
    XIndexedCustomTriangleSet,
    XIndexedCustomTriangleStripSet,
    XIndexedTriangleSet,
    XIndexedTriangleStripSet,
    XIntResourceDetails,
    XInteriorNode,
    XInternalSampleData,
    XJointTransform,
    XLightingEnable,
    XMaterial,
    XMatrix,
    XMeshDescriptor,
    XMissileTrailEmitter,
    XMultiIndexSet,
    XMultiTexCoordSet,
    XMultiTexFont,
    XMultiTexFontPage,
    XMultiTexShader,
    XNamedAttribute,
    XNormal3fSet,
    XNormal3sSet_1uScale,
    XNullDescriptor,
    XOglShadowSpotLight,
    XOglTextureMap,
    XOglTextureStage,
    XPalette,
    XPaletteWeightSet,
    XParticleEmitter,
    XPathFinderData,
    XPfxBasicEmission,
    XPfxCubeEmission,
    XPfxDragModule,
    XPfxEmissionEmitterGeom,
    XPfxEmitterGeom,
    XPfxFollowEmitterModule,
    XPfxGravityModule,
    XPfxParticleEffect,
    XPfxRingEmission,
    XPfxSizeLifeModule,
    XPfxSphereEmission,
    XPfxVelocityAlignModule,
    XPfxWindModule,
    XPlaneAlignedSpriteSet,
    XPointLight,
    XPositionData,
    XPsGeoSet,
    XPsProgReference,
    XPsProxyTexture,
    XPsShaderInstance,
    XPsShaderPrototype,
    XPsShape,
    XPsSkinShape,
    XPsTexFont,
    XPsTextureReference,
    XPsVertexDataSet,
    XSampleData,
    XSceneCamera,
    XSceneryEffectData,
    XShape,
    XSimpleShader,
    XSkeletonRoot,
    XSkin,
    XSkinShape,
    XSlFragProg,
    XSlGeoSet,
    XSlProxyTexture,
    XSlShader,
    XSlShaderInstance,
    XSlShadowMap,
    XSlTextureMap,
    XSlVertProg,
    XSnowEmitter,
    XSoundBank,
    XSpriteSet,
    XSpriteSetDescriptor,
    XStreamData,
    XStreamSet,
    XStringResourceDetails,
    XSystemStream,
    XTangent3fSet,
    XTechnique,
    XTexCoord2fSet,
    XTexFont,
    XTextDescriptor,
    XTexturePlacement2D,
    XTextureStage,
    XTransform,
    XUintResourceDetails,
    XUniformFloat,
    XUniformInstance,
    XUniformMatrixArray,
    XUniformProxy,
    XUniformShadowMatrix,
    XUniformTextureSize,
    XUniformTime,
    XUniformVector4f,
    XUniformViewMatrix,
    XUniformViewMatrixInverse,
    XUniformWorldViewMatrix,
    XUniformWorldViewProjectionMatrix,
    XVectorResourceDetails,
    XVertexShader,
    XVertexStream,
    XWeightSet,
    XXomInfoNode,
    XZBufferWriteEnable,
    XMax);
const
     PCharXTypes:array[XTypes] of PChar = ('XNone',
    'AIParametersContainer',
    'AcceptCancelButtonDesc',
    'AchievementsProgressContainer',
    'AssistedShotTweaks',
    'BaseWeaponContainer',
    'BrickBuildingCtr',
    'BrickBuildingList',
    'BrickLinkage',
    'BuildingGlobalContainer',
    'BuildingSpecificContainer',
    'CachedLeaderBoardWrite',
    'Campaign',
    'CampaignCollective',
    'CampaignData',
    'ChaseCameraPropertiesContainer',
    'ChatMessagesContainer',
    'ChatMessagesWindowDetails',
    'CheckBoxDesc',
    'ComboControlDesc',
    'ControlSetupDesc',
    'CrateDataContainer',
    'CreditsFMVs',
    'DamageStatsContainer',
    'DetailEntityStore',
    'EFMV_AnimateCustomHudGraphicEventContainer',
    'EFMV_AnimateDetailEventContainer',
    'EFMV_CastActorEventContainer',
    'EFMV_CommentEventContainer',
    'EFMV_ClearAccessoryEventContainer',
    'EFMV_CreateBordersEventContainer',
    'EFMV_CreateCustomHudGraphicEventContainer',
    'EFMV_CreateEmitterEventContainer',
    'EFMV_CreateExplosionEventContainer',
    'EFMV_CreateWXBriefingBoxEventContainer',
    'EFMV_CutCameraEventContainer',
    'EFMV_DeleteBordersEventContainer',
    'EFMV_DeleteCustomHudGraphicEventContainer',
    'EFMV_DeleteEmitterEventContainer',
    'EFMV_DeleteLandframeEventContainer',
    'EFMV_FailureCommentEventContainer',
    'EFMV_MovieContainer',
    'EFMV_PathCameraEventContainer',
    'EFMV_PlayAnimationEventContainer',
    'EFMV_ShakeCameraEventContainer',
    'EFMV_SpawnAccessoryEventContainer',
    'EFMV_SpawnParticleEventContainer',
    'EFMV_SpawnWormEventContainer',
    'EFMV_StopAnimationEventContainer',
    'EFMV_StopEventContainer',
    'EFMV_ThreatenWormEventContainer',
    'EFMV_TimedPathCameraEventContainer',
    'EFMV_TrackContainer',
    'EFMV_TriggerSoundEffectEventContainer',
    'EFMV_TriggerSpeechEventContainer',
    'EFMV_UnspawnWormEventContainer',
    'EFMV_WormBaseEventContainer',
    'EFMV_WormEmoteEventContainer',
    'EFMV_WormGestureAtEventContainer',
    'EFMV_WormLookAtEventContainer',
    'EffectDetailsContainer',
    'FlagDataContainer',
    'FlagLockIdentifier',
    'FlyCameraPropertiesContainer',
    'FlyingPayloadWeaponPropertiesContainer',
    'FMVSubTiles',
    'FMVTextLine',
    'FrameBoxDesc',
    'GSNetworkGameList',
    'GSProfile',
    'GSProfileList',
    'GSRoomList',
    'GSTeamList',
    'GameInitData',
    'GraphicEqualiserDesc',
    'GunWeaponPropertiesContainer',
    'HighScoreData',
    'HomingPayloadWeaponPropertiesContainer',
    'InputDetailsContainer',
    'InputEventMappingContainer',
    'InputMappingDetails',
    'IntegerArray',
    'JumpingPayloadWeaponPropertiesContainer',
    'LandFrameStore',
    'LandscapeBoxDesc',
    'LensFlareContainer',
    'LensFlareElementContainer',
    'LevelDetails',
    'LevelLock',
    'ListBoxData',
    'ListBoxIconColumn',
    'ListBoxStringColumn',
    'ListControlDesc',
    'ListHeaderControlDesc',
    'Lock',
    'LockedBitmapArray',
    'LockedBitmapDesc',
    'LockedContainer',
    'MeleeWeaponPropertiesContainer',
    'MenuButtonDesc',
    'MenuDescription',
    'MineFactoryContainer',
    'Mission',
    'Movie',
    'MovieLock',
    'MultiStateButtonDesc',
    'MultiStateTextButtonDesc',
    'OccludingCameraPropertiesContainer',
    'PC_LandChunk',
    'PC_LandFrame',
    'ParticleEmitterContainer',
    'ParticleMeshNamesContainer',
    'PayloadWeaponPropertiesContainer',
    'PercentButtonDesc',
    'PictureViewDesc',
    'PlayerList',
    'ProfileAchievementsContainer',
    'SavedLevel',
    'SavedLevelCollective',
    'SchemeColective',
    'SchemeCollective',
    'SchemeData',
    'SchemeDataContainer',
    'ShotStatsCollective',
    'SentryGunWeaponPropertiesContainer',
    'SimpleCameraContainer',
    'SoundBankColective',
    'SoundBankCollective',
    'SoundBankData',
    'StatsContainer',
    'StoreWeaponFactory',
    'StoredStatsCollective',
    'StoredTeamData',
    'StringQueue',
    'StringStack',
    'TeamAwardsContainer',
    'TeamCareerStats',
    'TeamDataColective',
    'TeamDataCollective',
    'TeamDataContainer',
    'TeamPersistDataContainer',
    'TextBoxDesc',
    'TextButtonDesc',
    'TextEditBoxDesc',
    'TitleTextDesc',
    'TrackCameraContainer',
    'TriggerDataContainer',
    'W3DLumpBoundBox',
    'W3DLumpConnector',
    'W3DTemplate',
    'W3DTemplateSet',
    'WXFE_AttachmentOffsets',
    'WXFE_BriefingDesc',
    'WXFE_ButtonHelpDesc',
    'WXFE_FlagObjectDesc',
    'WXFE_GalleryImageDesc',
    'WXFE_GalleryThumbDesc',
    'WXFE_GapColumns',
    'WXFE_GetControllerInputDesc',
    'WXFE_HighlightIconColumns',
    'WXFE_HowToPlayTextBoxDesc',
    'WXFE_IconColumns',
    'WXFE_ImageViewDesc',
    'WXFE_InputDesc',
    'WXFE_LandscapeBoxDesc',
    'WXFE_LevelDetails',
    'WXFE_ListBoxContents',
    'WXFE_ListBoxRows',
    'WXFE_ListControlDesc',
    'WXFE_ListDetailDesc',
    'WXFE_MenuButtonDesc',
    'WXFE_MenuDescription',
    'WXFE_MeshObjectDesc',
    'WXFE_MeshObjectParticleDesc',
    'WXFE_NewsFeedScrollingTextDesc',
    'WXFE_PlayerRepresentationObjectDesc',
    'WXFE_PowerColumns',
    'WXFE_ScrollingTextDesc',
    'WXFE_ShopDesc',
    'WXFE_SoftwareKeyBoardData',
    'WXFE_SoftwareKeyBoardDesc',
    'WXFE_StringColumns',
    'WXFE_StringTableColumns',
    'WXFE_TextBoxDesc',
    'WXFE_TextEditBoxDesc',
    'WXFE_TitleControlDesc',
    'WXFE_TrophyCabinetDesc',
    'WXFE_TrophyDesc',
    'WXFE_UnlockableItem',
    'WXFE_UnlockableItemSet',
    'WXFE_WeaponFactoryMeshDesc',
    'WXFE_WormAttachments',
    'WXFE_WormDesc',
    'WXFE_WormPotControlDesc',
    'WXLumpBoundBox',
    'WXLumpConnector',
    'WXTemplate',
    'WXTemplateSet',
    'WaterPlaneTweaks',
    'WeaponControlDesc',
    'WeaponDataCtr',
    'WeaponDelays',
    'WeaponFactoryAirstrikeCostContainer',
    'WeaponFactoryCollective',
    'WeaponFactoryContainer',
    'WeaponFactoryLanchedCostContainer',
    'WeaponFactoryThrownCostContainer',
    'WeaponInventory',
    'WeaponSettingsData',
    'WormCareerStats',
    'WormDataContainer',
    'WormPotContainer',
    'WormPotControlDesc',
    'WormStatsContainer',
    'WormapediaCollective',
    'WormapediaDetails',
    'WormpaediaColective',
    'WormpaediaDetails',
    'XAlphaTest',
    'XAnimChannel',
    'XAnimClipLibrary',
    'XAnimInfo',
    'XAttrPass',
    'XBasicEmitter',
    'XBillboardSpriteSet',
    'XBinModifier',
    'XBinSelector',
    'XBinormal3fSet',
    'XBitmapDescriptor',
    'XBlendModeGL',
    'XBone',
    'XBrickDetails',
    'XBrickGeometry',
    'XBrickIndexSet',
    'XBuildingShape',
    'XChildSelector',
    'XCollisionData',
    'XCollisionGeometry',
    'XColor4ubSet',
    'XColorResourceDetails',
    'XConstColorSet',
    'XContainerResourceDetails',
    'XCoord3fSet',
    'XCoord3sSet_1uScale',
    'XCullFace',
    'XCustomDescriptor',
    'XCustomShader',
    'XDataBank',
    'XDataFloat',
    'XDataMatrix4f',
    'XDataStreamDeclarator',
    'XDataVector4f',
    'XDepthTest',
    'XDetailObjectsData',
    'XDetailSwitch',
    'XDirectMusicDescriptor',
    'XEnvironmentMapShader',
    'XExpandedAnimInfo',
    'XExportAttributeString',
    'XFloatResourceDetails',
    'XFortsExportedData',
    'XGraphSet',
    'XGroup',
    'XImage',
    'XIndexSet',
    'XIndexSet8',
    'XIndexedCustomTriangleSet',
    'XIndexedCustomTriangleStripSet',
    'XIndexedTriangleSet',
    'XIndexedTriangleStripSet',
    'XIntResourceDetails',
    'XInteriorNode',
    'XInternalSampleData',
    'XJointTransform',
    'XLightingEnable',
    'XMaterial',
    'XMatrix',
    'XMeshDescriptor',
    'XMissileTrailEmitter',
    'XMultiIndexSet',
    'XMultiTexCoordSet',
    'XMultiTexFont',
    'XMultiTexFontPage',
    'XMultiTexShader',
    'XNamedAttribute',
    'XNormal3fSet',
    'XNormal3sSet_1uScale',
    'XNullDescriptor',
    'XOglShadowSpotLight',
    'XOglTextureMap',
    'XOglTextureStage',
    'XPalette',
    'XPaletteWeightSet',
    'XParticleEmitter',
    'XPathFinderData',
    'XPfxBasicEmission',
    'XPfxCubeEmission',
    'XPfxDragModule',
    'XPfxEmissionEmitterGeom',
    'XPfxEmitterGeom',
    'XPfxFollowEmitterModule',
    'XPfxGravityModule',
    'XPfxParticleEffect',
    'XPfxRingEmission',
    'XPfxSizeLifeModule',
    'XPfxSphereEmission',
    'XPfxVelocityAlignModule',
    'XPfxWindModule',
    'XPlaneAlignedSpriteSet',
    'XPointLight',
    'XPositionData',
    'XPsGeoSet',
    'XPsProgReference',
    'XPsProxyTexture',
    'XPsShaderInstance',
    'XPsShaderPrototype',
    'XPsShape',
    'XPsSkinShape',
    'XPsTexFont',
    'XPsTextureReference',
    'XPsVertexDataSet',
    'XSampleData',
    'XSceneCamera',
    'XSceneryEffectData',
    'XShape',
    'XSimpleShader',
    'XSkeletonRoot',
    'XSkin',
    'XSkinShape',
    'XSlFragProg',
    'XSlGeoSet',
    'XSlProxyTexture',
    'XSlShader',
    'XSlShaderInstance',
    'XSlShadowMap',
    'XSlTextureMap',
    'XSlVertProg',
    'XSnowEmitter',
    'XSoundBank',
    'XSpriteSet',
    'XSpriteSetDescriptor',
    'XStreamData',
    'XStreamSet',
    'XStringResourceDetails',
    'XSystemStream',
    'XTangent3fSet',
    'XTechnique',
    'XTexCoord2fSet',
    'XTexFont',
    'XTextDescriptor',
    'XTexturePlacement2D',
    'XTextureStage',
    'XTransform',
    'XUintResourceDetails',
    'XUniformFloat',
    'XUniformInstance',
    'XUniformMatrixArray',
    'XUniformProxy',
    'XUniformShadowMatrix',
    'XUniformTextureSize',
    'XUniformTime',
    'XUniformVector4f',
    'XUniformViewMatrix',
    'XUniformViewMatrixInverse',
    'XUniformWorldViewMatrix',
    'XUniformWorldViewProjectionMatrix',
    'XVectorResourceDetails',
    'XVertexShader',
    'XVertexStream',
    'XWeightSet',
    'XXomInfoNode',
    'XZBufferWriteEnable',
    'XMax');


  Ctnr  = $524e5443;//'CTNR';
  Ctnr2 = $53525453; //'STRS'

  TypeStr: PChar       = 'TYPE';
  FileHeadType: PChar  = 'MOIK';
  Schm: PChar          = 'SCHM';
  StrS: PChar          = 'STRS';
  CtnrS: PChar         = 'CTNR';
  Space: PChar         = '   ';

  STRIPGUID:TGUID       = '{F9EA3152-F471-4189-9AA5-3E374C0355CD}';
  TRIGUID:TGUID         = '{99504FA1-C2D2-4E88-972C-38194B782488}';// A1 4F 50 99 -D2 C2 -88 4E -97 2C -38 19 4B 78 24 88
  WSGUID:TGUID          = '{BE31B087-5E35-4657-A955-06A97C7E6E96}';// 87 B0 31 BE -35 5E -57 46 -A9 55 -06 A9 7C 7E 6E 96
  PWGUID:TGUID          = '{90034327-AFD5-43C2-AC26-D99120CF03CC}';// 27 43 03 90 -D5 AF -C2 43 -AC 26 -D9 91 20 CF 03 CC

   // Enum Section
 LevelTypeEnum:  array [0..7] of String = ('kCampagne','kRandom','kCustom','kTutorial','kChallenge','kMultiplayer','kAttract','kLast');
 ButtonColourEnum: array [0..5] of String = ('kButtonColourInvisible', 'kButtonColourBlue', 'kButtonColourGreen', 'kButtonColourRedBlue', 'kButtonColourPurple', 'kButtonColourRed');
 EdgeJustificationEnum: array [0..8] of String = ('kEdgeJustifyTopLeft' , 'kEdgeJustifyTopCentre' , 'kEdgeJustifyTopRight' , 'kEdgeJustifyCentreLeft' , 'kEdgeJustifyCentreCentre'
 , 'kEdgeJustifyCentreRight' , 'kEdgeJustifyBottomLeft' , 'kEdgeJustifyBottomCentre' , 'kEdgeJustifyBottomRight');
 FrameBoxTextPosition:   array [0..5] of String = ('kTextPosTopLeft', 'kTextPosTopCentre', 'kTextPosTopRight', 'kTextPosBottomLeft', 'kTextPosBottomCentre', 'kTextPosBottomRight');
 RowBackgroundType: array [0..3] of String = ('kBackNone', 'kBackSolid', 'kBackBars', 'kBackBlocks');
 LockedTypeEnum: array [0..6] of String = ( 'kLockSoundBank', 'kLockScheme', 'kLockWeapon', 'kLockChallenge', 'kLockWormPaedia', 'kLockLandscape', 'kLockLast');
 MedalsEnum: array [0..3] of String = ('kNoMedal', 'kBronzeMedal', 'kSilverMedal', 'kGoldMedal');
 WeaponNameEnum: array [0..61] of String = ('kWeaponBazooka','kWeaponGrenade','kWeaponClusterGrenade','kWeaponAirstrike','kWeaponDynamite','kWeaponHolyHandGrenade','kWeaponBananaBomb',
'kWeaponLandmine','kWeaponShotgun','kWeaponUzi','kWeaponBaseballBat','kWeaponProd','kWeaponVikingAxe','kWeaponFirePunch','kWeaponHomingMissile',
'kWeaponMortar','kWeaponHomingPidgeon','kWeaponEarthquake','kWeaponSheep','kWeaponMineStrike','kWeaponPetrolBomb','kWeaponGasCanister',
'kWeaponSheepStrike','kWeaponMadCow','kWeaponOldWoman','kWeaponConcreteDonkey','kWeaponNuclearBomb','kWeaponArmageddon','kWeaponMagicBullet',
'kWeaponSuperSheep','kWeaponBlowpipe','kWeaponLotteryStrike','kWeaponDoctorsStrike','kWeaponMegaMine','kWeaponStickyBomb','kUtilityBinoculars',
'kWeaponClusterBomb','kWeaponBananette','kWeaponMortarBomblet','kUtilityGirder','kUtilityBridgeKit','kUtilityNinjaRope','kUtilityParachute',
'kUtilityScalesOfJustice','kUtilityLowGravity','kUtilityQuickWalk','kUtilityLaserSight','kUtilityTeleport','kUtilityJetpack','kUtilitySkipGo',
'kUtilitySurrender','kUtilityChangeWorm','kUtilityFreeze','kUtilityRedbull','kUtilityDoubleDamage','kUtilityDoubleTurnTime','kUtilityCrateShower',
'kUtilityCrateSpy','kUtilityBuffalo','kInventorySize','kWeaponUndefined','kWeaponTerminal');
 CameraDistanceEnum: array [0..1] of String = ('kCloseup','kLongshot');
 ParticleTypeEnum: array [0..3] of String = ('kNormal','kSnow','kRain','kTrail');
 WormCollideEnum: array [0..3] of String = ('kWC_Standard', 'kWC_Expire', 'kWC_Lightside', 'kWC_Darkside');
 LandCollideEnum: array [0..3] of String = ('kLC_Bounce', 'kLC_Expire', 'kLC_StopMoving', 'kLC_StopMovingAndAttach');
 WUMLandCollideEnum: array [0..4] of String = ('kLC_None','kLC_Bounce', 'kLC_Expire', 'kLC_StopMoving', 'kLC_StopMovingAndAttach');

 ParticleSceneEnum: array [0..5] of String = ('kPS_Default', 'kPS_Scene1', 'kPS_Scene2', 'kPS_Scene3', 'kPS_Scene4', 'kPS_Scene5');
 LensElementType: array [0..7] of String = ('kLens_SunGlow','kLens_Circle','kLens_FadedRing','kLens_Ring','kLens_FadedHex','kLens_Hex','kLens_RainbowRing','kLens_NumElementTypes');
 LumpTypeEnum: array [0..23] of String = ('kLT_SmallFlatLand','kLT_SmallMedLand','kLT_SmallTallLand','kLT_MedFlatLand','kLT_MedMedLand','kLT_MedTallLand','kLT_BigFlatLand','kLT_BigMedLand','kLT_BigTallLand','kLT_SmallBeach','kLT_MedBeach','kLT_BigBeach','kLT_SmallGap','kLT_MedGap','kLT_LongGap','kLT_SmallPillarGap','kLT_MedPillarGap','kLT_TallPillarGap','kLT_SmallBridge','kLT_MedBridge','kLT_LongBridge','kLT_SmallObject','kLT_LargeObject','kLT_NumTypes');
 PreviewTypeEnum: array [0..6] of String = ('kPT_None', 'kPT_LandLow', 'kPT_LandHigh', 'kPT_BeachLow', 'kPT_BeachHigh', 'kPT_Bridge', 'kPT_Float');
 WeaponTypeEnum: array [0..11] of String = ('kNoType','kUtility','kProjectile','kTargetted','kThrown','kMelee','kEnvironment','kHitscan','kAnimal','kControlled','kStrike','kMovement');
 NetworkGameStateEnum: array [0..3] of String = ('kNGS_Setup','kNGS_StagingRoom','kNGS_Playing','kNGS_Debrief');
 RoomTypeEnum: array [0..2] of String = ('kR_Group','kR_Title','kR_Staging');
 UpdateMode: array [0..2] of String = ('kUpdateModeStatic','kUpdateModeDynamic','kUpdateModeIgnore');
 RotateOrder: array [0..5] of String = ( 'kRotateOrderXYZ', 'kRotateOrderYZX', 'kRotateOrderZXY', 'kRotateOrderXZY', 'kRotateOrderYXZ', 'kRotateOrderZYX');
 DetailMode: array [0..1] of String = ('kDetailModeDynamic','kDetailModeStatic');
 MaterialColorSource: array [0..2] of String = ('kMaterialColorSourceMaterial','kMaterialColorSourceColor1','kMaterialColorSourceColor2');
 CompareFunction: array [0..7] of String = ('kCompareFunctionNever', 'kCompareFunctionLess', 'kCompareFunctionEqual', 'kCompareFunctionLessEqual', 'kCompareFunctionGreater',
 'kCompareFunctionNotEqual', 'kCompareFunctionGreaterEqual', 'kCompareFunctionAlways');
 StencilOp: array [0..7] of String = ('kStencilOpKeep', 'kStencilOpZero', 'kStencilOpReplace', 'kStencilOpIncrClamp', 'kStencilOpDecrClamp', 'kStencilOpInvert',
  'kStencilOpIncrWrap', 'kStencilOpDecrWrap');
 ShadeMode: array [0..3] of String = ('kShadeModeInvalid','kShadeModeFlat','kShadeModeSmooth','kShadeModePhong');
 CullMode: array [0..4] of String = ('kCullModeOff','kCullModeFront','kCullModeBack','kCullModeForceFront','kCullModeForceBack');
 FillMode: array [0..3] of String = ('kFillModeInvalid','kFillModePoint','kFillModeWireFrame','kFillModeSolid');
 FadeMode: array [0..3] of String = ('kFadeModeNone','kFadeModeFadeIn','kFadeModeFadeOut','kFadeModeFadeInOut');
 BlendMode: array [0..1] of String = ('kBlendModeNormal','kBlendModeAdditive');
 ColourChange: array [0..3] of String = ('kColourChangeNone','kColourChangeSingleStage','kColourChangeTwoStage','kColourChangeStatic');
 SizeChange: array [0..2] of String = ('kSizeChangeNone','kSizeChangeSingleStage','kSizeChangeTwoStage');
 EmitterShape: array [0..3] of String = ('kEmitterShapePoint','kEmitterShapeDisc','kEmitterShapeSphere','kEmitterShapeCylinder');
 RotationDirection: array [0..4] of String = ('kRotationDirectionNone','kRotationDirectionClockwise','kRotationDirectionCounterClockwise','kRotationDirectionAny','kRotationDirectionStatic');




 NormalizeMode: array [0..2] of String = ('kNormalizeNever','kNormalizeAlways','kNormalizeIfRequired');
 FogMode: array [0..3] of String = ('kFogModeNone','kFogModeExp','kFogModeExp2','kFogModeLinear');
 FilterMode: array [0..4] of String = ('kFilterModeNone','kFilterModeNearest','kFilterModeLinear','kFilterModeAnisotropic','kFilterMode_Count');
 BlendFactor: array [0..11] of String = ('kBlendFactorZero', 'kBlendFactorOne', 'kBlendFactorDestColor', 'kBlendFactorOneMinusDestColor', 'kBlendFactorSrcColor', 'kBlendFactorOneMinusSrcColor', 'kBlendFactorSrcAlpha', 'kBlendFactorOneMinusSrcAlpha', 'kBlendFactorDestAlpha', 'kBlendFactorOneMinusDestAlpha', 'kBlendFactorSrcAlphaSaturate', 'kBlendFactorMinusOne');
 ImageFormat: array [0..26] of String = ('kImageFormat_R8G8B8', 'kImageFormat_A8R8G8B8', 'kImageFormat_X8R8G8B8', 'kImageFormat_X1R5G5B5', 'kImageFormat_A1R5G5B5', 'kImageFormat_R5G6B5',
  'kImageFormat_A8', 'kImageFormat_P8', 'kImageFormat_P4', 'kImageFormat_DXT1', 'kImageFormat_DXT3', 'kImageFormat_NgcRGBA8', 'kImageFormat_NgcRGB5A3', 'kImageFormat_NgcR5G6B5', 'kImageFormat_NgcIA8', 'kImageFormat_NgcIA4', 'kImageFormat_NgcI8', 'kImageFormat_NgcI4', 'kImageFormat_NgcCI12A4', 'kImageFormat_NgcCI8', 'kImageFormat_NgcCI4', 'kImageFormat_NgcCMPR', 'kImageFormat_NgcIndirect',
  'kImageFormat_P2P8', 'kImageFormat_P2P4', 'kImageFormat_Linear', 'kImageFormat_Count');
 PaletteFormat: array [0..5] of String = ('kPaletteFormat_R8G8B8X8', 'kPaletteFormat_R8G8B8A8', 'kPaletteFormat_R5G5B5', 'kPaletteFormat_R5G6B5', 'kPaletteFormat_NgcRGB5A3', 'kPaletteFormat_Count');
 AddressMode: array [0..4] of String = ('kAddressModeInvalid', 'kAddressModeRepeat', 'kAddressModeMirror', 'kAddressModeClamp', 'kAddressModeBorder');
 OglBlend: array [0..3] of String = ('kOglBlendReplace','kOglBlendModulate','kOglBlendDecal','kOglBlendBlend');
 // WUM section
 FMVSubTiles_FMV: array [0..5] of String = ('kFMVSTF_None','kFMVSTF_MeetTheProfessor','kFMVSTF_Camelot','kFMVSTF_WildWest','kFMVSTF_Arabian','kFMVSTF_Jurassic');

 CoordFormatEnum: array [0..4] of String = ('kCoordInvalid','kCoord3f','kCoord3s','kCoord3s_4fScale','kCoord3s_1uScale');
 NormalFormatEnum: array [0..6] of String = ('kNormalInvalid','kNormal3f','kNormal3s','kNormal3s_1uScale','kNormal3b','kNormal4f','kNormal4b');
 ColorFormatEnum: array [0..4] of String = ('kColorInvalid','kColor4ub','kColor4f','kColor4444','kConstColor');
 TexCoordFormatEnum: array [0..6] of String = ('kTexCoordInvalid','kTexCoordMulti','kTexCoord2f','kTexCoord3f','kTexCoord2s','kTexCoord4s','kTexCoord2b');
 WeightFormatEnum: array [0..2] of String = ('kWeightInvalid','kWeight','kPaletteWeight');
 InterleavedGeomEnum: array [0..1] of String = ('kIntGeoType_Normal','kIntGeoType_Stripped');
 ExportAttributeType: array [0..4] of String = ('kExportAttributeNone','kExportAttributeString','kExportAttributeInt','kExportAttributeFloat','kExportAttribureBool');
 GradientFlags: array [0..3] of String = ('kGradientNone','kGradientTop','kGradientBottom','kGradientBoth');//XMultiPageSpriteSet
 ImageFormatWUM: array [0..26] of String = ('kImageFormat_R8G8B8','kImageFormat_A8R8G8B8','kImageFormat_X8R8G8B8','kImageFormat_X1R5G5B5','kImageFormat_A1R5G5B5','kImageFormat_R5G6B5',
'kImageFormat_A8','kImageFormat_P8','kImageFormat_P4','kImageFormat_DXT1','kImageFormat_DXT3','kImageFormat_NgcRGBA8','kImageFormat_NgcRGB5A3','kImageFormat_NgcR5G6B5',
'kImageFormat_NgcIA8','kImageFormat_NgcIA4','kImageFormat_NgcI8','kImageFormat_NgcI4','kImageFormat_NgcCI12A4','kImageFormat_NgcCI8','kImageFormat_NgcCI4','kImageFormat_NgcCMPR',
'kImageFormat_NgcIndirect','kImageFormat_P2P8','kImageFormat_P2P4','kImageFormat_Linear','kImageFormat_Count');
 InfinityType: array [0..5] of String = ('kInfinityConstant','kInfinityLinear','kInfinityCycle','kInfinityCycleRelative','kInfinityOscillate','kInfinityInvalid');
 DetonationTypeEnum: array [0..4] of String = ('kDT_Random','kDT_Normal','kDT_Fire','kDT_Clusters','kDT_BigPush'); //PayloadWeaponPropertiesContainer
 WormCollideResponseEnum: array [0..2] of String = ('kWC_Default','kWC_StealInventory','kWC_FloatAway');
 MeleeWeaponEnum: array [0..4] of String = ('kNoMeleeType','kMeleeBaseballBat','kMeleeFirepunch','kMeleeProd','kMeleeTailNail');
 MessageAction: array [0..7] of String = ('kAction_Add','kAction_Remove','kAction_Update','kAction_AddDenied','kAction_RemoveDenied','kAction_UpdateDenied','kAction_RequestDigest','kLastAction');//TeamMessage.Action <XEnum>
 AttachmentTypeEnum: array [0..4] of String = ('kAttachmentHat','kAttachmentGloves','kAttachmentGlasses','kAttachmentMustache','kAttachmentPartialHat');
 InputMappingTypeEnum: array [0..15] of String = ('kIM_Keyboard','kIM_MouseButton','kIM_JoystickButton','kIM_JoystickAxis','kIM_MouseSensitivity','kIM_InvertX','kIM_InvertY','kIM_BackFlip','kIM_Vibration','kIM_Other',
'kIM_Undefined','kIM_InvertYFP','kIM_JoystickPov','kIM_PreSetJoypadConfig','kIM_UndefinedButAllowed','kIM_LAST');
 WeaponFactoryTypeEnum: array [0..1] of String = ('kWT_Projectile','kWT_Cluster');
 WeaponFactoryDetonateEnum: array [0..3] of String = ('kWD_Impact','kWD_Fused','kWD_FirePress','kWD_AtRest');
 WeaponPayLoadEnum: array [0..62] of String = ('kWP_8ball','kWP_Banana','kWP_Baseball','kWP_Bazookashell','kWP_Beans','kWP_Beechball','kWP_Bomb2','kWP_Book','kWP_Boot','kWP_BowlingBall','kWP_Brick','kWP_Burger','kWP_C4','kWP_Canary',
 'kWP_Cheese','kWP_Chicken','kWP_Classic','kWP_Cluster','kWP_Dice','kWP_Doll','kWP_Donut','kWP_Dumbell','kWP_Easterhead','kWP_Eyeball','kWP_Fish','kWP_Foot','kWP_Globe','kWP_Grenade','kWP_Hamster','kWP_Hotdog','kWP_Kitten','kWP_Looroll',
 'kWP_MagicBullet','kWP_Meat','kWP_Mingvase','kWP_Monkey','kWP_MorningStar','kWP_Nut','kWP_Parcel','kWP_Penguin','kWP_Pineapple','kWP_Poo','kWP_Present','kWP_Rabbit','kWP_RazorBall','kWP_Rubikcube','kWP_ShrunkenHead','kWP_Sickbucket','kWP_Skull',
 'kWP_Snowglobe','kWP_Teeth','kWP_Tonweight','kWP_USfootball','kWP_DLC1Payload1','kWP_DLC1Payload2','kWP_DLC1Payload3','kWP_DLC1Payload4','kWP_DLC1Payload5','kWP_Bullet','kWP_Bomb','kWP_Rocket','kWP_Lazer','kWP_LAST');
 WeaponFactoryLaunchEnum: array [0..4] of String = ('kWL_Bomber','kWL_Launched','kWL_Thrown','kWL_Dropped','kWL_LauchLAST');
 WXFE_UnlockResourceTypeEnum: array [0..12] of String = ('kURT_Unknown','kURT_SoundBank','kURT_Map','kURT_Hat','kURT_Spectacles','kURT_Hands','kURT_FacialHair','kURT_Weapon','kURT_WeaponScheme','kURT_CharacterSet','kURT_CharacterSetItem','kURT_Loyalty','kURT_NumTypes');
 WXFE_UnlockableStateEnum: array [0..2] of String = ('kUS_Hidden','kUS_Purchasable','kUS_Unlocked');
 WXFE_BorderTypeEnum: array [0..47] of String = ('kMT_NoBorder','kMT_FrameBorder','kMT_BasicBorder','kMT_ArmouryBorder','kMT_BlueListBorder','kMT_OrangeListBorder',
'kMT_TextNormalBorder','kMT_TextDisabledBorder','kMT_TextEditBorder','kMT_TextHighlightBorder','kMT_TextActiveBorder',
'kMT_TextCharcoalBorder','kMT_ButtonSmallNormal','kMT_ButtonSmallDisabled','kMT_ButtonSmallHighlight','kMT_ButtonBigNormal',
'kMT_ButtonBigDisabled','kMT_ButtonBigHighlight','kMT_NavStartNormal','kMT_NavStartDisabled','kMT_NavStartHighlight',
'kMT_NavTickNormal','kMT_NavTickDisabled','kMT_NavTickHighlight','kMT_NavBackNormal','kMT_NavBackDisabled','kMT_NavBackHighlight',
'kMT_NavCrossNormal','kMT_NavCrossDisabled','kMT_NavCrossHighlight','kMT_NavArrowLeftNorm','kMT_NavArrowLeftHighlight',
'kMT_NavArrowLeftDisabled','kMT_NavArrowRightNorm','kMT_NavArrowRightHighlight','kMT_NavArrowRightDisabled','kMT_BubbleBorder',
'kMT_BubbleBorderNoPointer','kMT_PaperBorder','kMT_BorderNamePlate','kMT_ComPanelBorder','kMT_PaperNormalBorder','kMT_PaperShadowBorder',
'kMT_MemoryNormalBorder','kMT_MemoryHighlightBorder','kMT_MemoryHighlightDisabled','kMT_ComPanelBorderTrans','kMT_LAST');
 WXFE_GradientColours: array [0..34] of String = ('kGC_Invalid','kGC_Blank','kGC_Solid_White','kGC_Solid_Black','kGC_Solid_Team_Blue','kGC_Solid_Team_Red','kGC_Solid_Team_Green','kGC_Solid_Team_Yellow','kGC_Header_Orange',
 'kGC_SubHeader_Blue','kGC_TextBox_Yellow','kGC_List_Lable_Blue','kGC_List_Data_Orange','kGC_Button_Yellow','kGC_Wormpot_Orange','kGC_Team_Red','kGC_Team_Blue','kGC_Team_Green','kGC_Team_Yellow','kGC_Disabled_Grey',
 'kGC_Disabled_Grey_Light','kGC_PressFire_Turquoise','kGC_TextEdit_Turquoise','kGC_Book_Brown','kGC_PopUp_Red','kGC_PopUp_Blue','kGC_PopUp_Brown','kGC_PopUp_LightBrown','kGC_PopUp_Green','kGC_ScrollText','kGC_TextBox_Green',
 'kGC_ERROR_RED','kGC_List_Lable_Cluster','kGC_ControllerUndefined','kGC_LAST_Dont_Use');
 WXFE_BackgroundColours: array [0..7] of String = ('kBC_Invalid','kBC_Blank','kBC_Black','kBC_White','kBC_Dark','kBC_ScrollText','kBC_ControllerUndefined','kBC_LAST_Dont_Use');
 WXFE_TextAnimationEnum: array [0..5] of String = ('kTA_None','kTA_LargeWobble','kTA_SmallWobble','kTA_TitleRandom','kTA_MediumWobble','kTA_LAST_DontUse');
 WXFE_ControlAnimsEnum: array [0..29] of String = ('kANIM_None','kANIM_Click','kANIM_Click_Error','kANIM_Highlight','kANIM_In_BigBounce','kANIM_In_Flipy','kANIM_In_Next','kANIM_In_Prev','kANIM_In_ScaleHitXY','kANIM_In_ScaleY',
 'kANIM_In_SlideX','kANIM_In_Speech','kANIM_In_SpringX','kANIM_In_SpringXY','kANIM_In_TitleUnderline','kANIM_In_ToolTip','kANIM_Out_Next','kANIM_Out_Prev','kANIM_Out_ScaleX','kANIM_Out_ScaleXY','kANIM_Out_ScaleY','kANIM_Out_Speech',
 'kANIM_Out_TitleUnderline','kANIM_Out_ToolTip','kANIM_Reset','kANIM_Title_Scroll','kANIM_Wide_Highlight','kANIM_In_Chat','kANIM_Out_Chat','kANIM_LAST');
 WXFE_ControlAudioEnum: array [0..41] of String = ('kAUDIO_None','kAUDIO_Cancel','kAUDIO_Click','kAUDIO_Click2','kAUDIO_Click3','kAUDIO_Error','kAUDIO_Grenade','kAUDIO_Highlight','kAUDIO_In_BigBounce','kAUDIO_In_Book',
 'kAUDIO_In_Controller','kAUDIO_In_CrateDice','kAUDIO_In_Custom','kAUDIO_In_Net','kAUDIO_In_Next','kAUDIO_In_Prev','kAUDIO_In_ScaleHitXY','kAUDIO_In_ScaleY','kAUDIO_In_SlideX','kAUDIO_In_SoundVid','kAUDIO_In_Speech','kAUDIO_In_SpringX',
 'kAUDIO_In_WeaponFactory','kAUDIO_In_WormPot','kAUDIO_Out_Book','kAUDIO_Out_Next','kAUDIO_Out_Prev','kAUDIO_Out_Scale','kAUDIO_Out_ScaleXY','kAUDIO_Out_ScaleY','kAUDIO_Typewriter','kAUDIO_WormPot_Button','kAUDIO_WormPot_HandlePull',
 'kAUDIO_WormPot_Intro','kAUDIO_WormPot_Nudge','kAUDIO_WormPot_Outro','kAUDIO_WormPot_Spin_Loop','kAUDIO_WormPot_Spin_Start','kAUDIO_WormPot_Spin_Stop','kAUDIO_Page_Turn','kAUDIO_Typewriter_Delete','kAUDIO_LAST');
 GapTypeEnum: array [0..3] of String = ('kGAP_Normal','kGAP_Dots','kGAP_Line','kGAP_LAST');
 PowerColumnStyleEnum: array [0..4] of String = ('kPCS_Normal','kPCS_Grow','kPCS_NormalZeroDisable','kPCS_GrowZeroDisable','kPCS_LAST');
 WXFE_LevelTypeEnum: array [0..18] of String = ('kLT_Multiplayer','kLT_MultiplayerDestruction','kLT_MultiplayerDefend','kLT_MultiplayerSurvivor','kLT_Story','kLT_Random','kLT_Tutorial','kLT_Challenge_Endurance','kLT_Challenge_Quickest',
 'kLT_Deathmatch','kLT_ChallengeRESERVED','kLT_MultiplayerFort','kLT_Network','kLT_NetworkDemo','kLT_ChallengeW3D','kLT_StoryW3D','kLT_Outtake','kLT_ERROR','kLT_Last');
 WXFE_LevelThemeTypeEnum: array [0..12] of String = ('kTT_Ababian','kTT_Wildwest','kTT_Camelot','kTT_Prehistoric','kTT_Building','kTT_PreSelectedTheme','kTT_Arctic','kTT_England','kTT_Horror','kTT_Lunar','kTT_Pirate','kTT_War','kTT_Last_Do_Not_Select');
 WXFE_LevelPreviewEnum: array [0..2] of String = ('kPT_ImagePreview','kPT_GeneratePreview','kPT_Last_Do_Not_Select');
 WXFE_LevelSectionEnum: array [0..4] of String = ('kLS_Undefined','kLS_RandomTheme','kLS_MayhemPreBuilt','kLS_Worms3DPreBuilt','kLS_Saved');
 WXFE_PositionalEnum: array [0..3] of String = ('kPO_Top','kPO_Middle','kPO_Bottom','kPO_LAST_DontUse');
 XResourceGUID: array[0..7] of TGUID = (
        '{7D889B8D-2C14-445E-961F-5E0E5520416A}',
        '{93E5117C-8ADA-4AFB-B17A-668D0BDD15E6}',
        '{7CDC5872-2CA3-4FCC-AE66-431071E5CE67}',
        '{08889D5F-8039-4CEA-BA5B-9C059AC0570E}',
        '{071F4563-8CB3-4996-B79F-B0F5CAEC9D99}',
        '{E0B6BF20-F80B-4329-B6EB-1998ED8AEC1F}',
        '{E0B6BF20-F80B-4329-B6EB-1998ED8AEC1F}',
        '{7804BA7B-C6FD-4E8E-AFFF-8E266B6A5544}');
 XResourceXTypes:array[0..7] of XTypes = (XIntResourceDetails,XUintResourceDetails,XStringResourceDetails,
        XFloatResourceDetails,XVectorResourceDetails,XContainerResourceDetails,XContainerResourceDetails,XColorResourceDetails);
 XResourceDetails: array [0..7] of String = ('IntResources','UintResources','StringResources',
        'FloatResources','VectorResources','ContainerResources','StringTableResources','ColorResources');

ImageFormatWR: array [0..39] of String = ('R8G8B8','A8R8G8B8','X8R8G8B8','X1R5G5B5','A1R5G5B5','R5G6B5','A8','P8','P4','DXT1','DXT3','DXT5','NgcRGBA8','NgcRGB5A3','NgcR5G6B5',
'NgcIA8','NgcIA4','NgcI8','NgcI4','NgcCI12A4','NgcCI8','NgcCI4','NgcCMPR','NgcIndirect','P2P8','P2P4','Linear','F16RGB','F16RGBA','F32RGB','F32RGBA','F16RG','D16','D24','D32',
'FD32','D24S8','A8R8G8B8_SCE','X8R8G8B8_LE','Count');

ImageFormatW3D: array [0..26] of String = ('R8G8B8','A8R8G8B8','X8R8G8B8','X1R5G5B5','A1R5G5B5','R5G6B5','A8','P8','P4','DXT1','DXT3','NgcRGBA8','NgcRGB5A3','NgcR5G6B5',
'NgcIA8','NgcIA4','NgcI8','NgcI4','NgcCI12A4','NgcCI8','NgcCI4','NgcCMPR','NgcIndirect','P2P8','P2P4','Linear','Count');

WRComprOp: array [0..4] of string = ('None','UseBest','ForceDXT1','ForceDXT3','ForceDXT5');

 WUMWeapon: array [1..58] of String = ('Airstrike','BananaBomb','BaseballBat','Bazooka','ClusterGrenade','ConcreteDonkey','CrateShower','CrateSpy','DoubleDamage','Dynamite',
'FirePunch','GasCanister','Girder','Grenade','HolyHandGrenade','HomingMissile','Jetpack','Landmine','NinjaRope','OldWoman','Parachute',
'Prod','SelectWorm','Sheep','Shotgun','SkipGo','SuperSheep','Redbull','Flood','Armour','WeaponFactoryWeapon','AlienAbduction','Fatkins',
'Scouser','NoMoreNails','PoisonArrow','SentryGun','SniperRifle','SuperAirstrike','BubbleTrouble','Starburst','Surrender','Binoculars','MineLayerMystery',
'MineTripletMystery','BarrelTripletMystery','FloodMystery','DisarmMystery','TeleportMystery','QuickWalkMystery','LowGravityMystery',
'DoubleTurnTimeMystery','HealthMystery','DamageMystery','SuperHealthMystery','SpecialWeaponMystery','BadPoisonMystery','GoodPoisonMystery');

 W4Weapon: array [1..57] of String = ('Airstrike','BananaBomb','BaseballBat','Bazooka','ClusterGrenade','ConcreteDonkey','CrateShower','CrateSpy','DoubleDamage','Dynamite',
'FirePunch','GasCanister','Girder','Grenade','HolyHandGrenade','HomingMissile','Jetpack','Landmine','NinjaRope','OldWoman','Parachute',
'Prod','SelectWorm','Sheep','Shotgun','SkipGo','SuperSheep','Redbull','Flood','Armour','WeaponFactoryWeapon','AlienAbduction','Fatkins',
'Scouser','NoMoreNails','PoisonArrow','SentryGun','SniperRifle','SuperAirstrike','BubbleTrouble','Starburst','Surrender','MineLayerMystery',
'MineTripletMystery','BarrelTripletMystery','FloodMystery','DisarmMystery','TeleportMystery','QuickWalkMystery','LowGravityMystery',
'DoubleTurnTimeMystery','HealthMystery','DamageMystery','SuperHealthMystery','SpecialWeaponMystery','BadPoisonMystery','GoodPoisonMystery');


 W3DWeapon: array [1..54] of String = ('Airstrike','Armageddon','BananaBomb','BaseballBat','Bazooka','Binoculars','Blowpipe','BridgeKit','ClusterGrenade','ConcreteDonkey','CrateShower',
'CrateSpy','DoctorsStrike','DoubleDamage','DoubleTurnTime','Dynamite','Earthquake','FirePunch','Freeze','GasCanister','Girder','Grenade',
'HolyHandGrenade','HomingMissile','HomingPigeon','Jetpack','Landmine','LaserSight','LotteryStrike','LowGravity','MadCow','MagicBullet','MegaMine','MineStrike',
'Mortar','NinjaRope','NuclearBomb','OldWoman','Parachute','PetrolBomb','Prod','QuickWalk','ScalesOfJustice','SelectWorm',
'Sheep',
//'SheepStrike',
'SkipGo','Shotgun','Surrender','StickyBomb','SuperSheep','Teleport',
'Uzi','VikingAxe','Redbull');

 WFWeapon: array [1..55] of String = ('Bazooka','Mortar','FireWeapon','HomingPigeon','RocketLauncher','Grenade','ClusterLauncher','FireGrenadeLauncher',
'BananaBombLauncher','Trebuchet','Canary','OldLady','BatteringRam','SuperHippo','MonkeyHerd','AirStrike','NapalmStrike','MineStrike','AnimalStrike',
'TrojanDonkey','ElectricalStorm','Earthquake','Flood','NuclearStrike','Armageddon','FirePunch','Ballista','MiniGun','GiantCrossbow','GiantLaser',
'Tower','Keep','Castle','Citadel','Wall','Hospital','Refinery','ScienceLab','Wonder','Farm','SiegeWorkshop','Storehouse','MasonsGuild','Market','Stronghold',
'Jetpack','Freeze','WormSelect','Parachute','Girder','RepairBuilding','SpawnWorm','SkipGo','Suicide','Surrender');

 WUMWeaponNameEnum: array [0..68] of String = (
'kWeaponOneBeforeFirst', 'kWeaponBazooka', 'kWeaponGrenade', 'kWeaponClusterGrenade', 'kWeaponAirstrike', 'kWeaponDynamite', 'kWeaponHolyHandGrenade', 'kWeaponBananaBomb', 'kWeaponLandmine',
'kWeaponShotgun', 'kWeaponBaseballBat', 'kWeaponProd', 'kWeaponFirePunch', 'kWeaponHomingMissile', 'kWeaponFlood', 'kWeaponSheep', 'kWeaponGasCanister', 'kWeaponOldWoman', 'kWeaponConcreteDonkey',
'kWeaponSuperSheep', 'kWeaponStarburst', 'kWeaponFactoryWeapon', 'kWeaponAlienAbduction', 'kWeaponFatkins', 'kWeaponScouser', 'kWeaponNoMoreNails', 'kWeaponPoisonArrow', 'kWeaponSentryGun', 'kWeaponSniperRifle',
'kWeaponSuperAirstrike', 'kWeaponClusterBomb', 'kWeaponBananette', 'kWeaponOneAfterLast', 'kUtilityOneBeforeFirst', 'kUtilityGirder', 'kUtilityNinjaRope', 'kUtilityParachute', 'kUtilityJetpack', 'kUtilitySkipGo', 'kUtilitySurrender',
'kUtilityChangeWorm', 'kUtilityRedbull', 'kUtilityBubbleTrouble', 'kUtilityBinoculars', 'kUtilityDoubleDamage', 'kUtilityCrateShower', 'kUtilityCrateSpy', 'kUtilityArmour', 'kUtilityOneAfterLast', 'kMysteryOneBeforeFirst',
'kMysteryMineLayer', 'kMysteryMineTriplet', 'kMysteryBarrelTriplet', 'kMysteryFlood', 'kMysteryDisarm', 'kMysteryTeleport', 'kMysteryQuickWalk', 'kMysteryLowGravity', 'kMysteryDoubleTurnTime', 'kMysteryHealth', 'kMysteryDamage',
'kMysterySuperHealth', 'kMysterySpecialWeapon', 'kMysteryBadPoison', 'kMysteryGoodPoison', 'kMysteryOneAfterLast', 'kInventorySize', 'kWeaponUndefined', 'kWeaponTerminal');

 ListEpochs: array [0..3] of String = ('Medieval','Oriental','Egypt','Greek');

 ListWFSky: array [0..19] of String = ('Medieval(Day)','Medieval(Evening)','Medieval(Night)',
        'Greek(Evening)','Greek(Day)','Greek(Night)','Oriental(Day)','Oriental(Evening)',
        'Oriental(Night)','Egypt(Day)','Egypt(Evening)','Egypt(Night)',
        'Coliseum of Doom Sky(Day)','Unused Red Sky(Evening)',
        'Mordred And Morgana(Hell)','A Quest(Day)','Pharaoh enough!(Day)',
        'The Kingdom is Born(Night)','Tower of Power Sky (Evening)',
        'Chess Mate Sky (Evening)');
 ListWFWater: array [0..3] of String = ('WATER','LAVA','CLOUD','SAND');
 ListWFBuild: array [0..16] of string = ('TOWER','KEEP','CASTLE','CITADEL','WALL','HOSPITAL',
        'REFINERY','SCIENCELAB','WONDER','-','-','-','-','-','STRONGHOLD','LIGHT','NONE');
 WXWormPhysicsStateEnum: array [0..9] of string = ('kWPS_Ambulatory', 'kWPS_DetectJump', 'kWPS_Ballistic', 'kWPS_Sliding', 'kWPS_Vaulting', 'kWPS_Override', 'kWPS_Passive', 'kWPS_DeathThroes', 'kWPS_DrownFloat', 'kWPS_Undefined');

type

  TXCtrls = record
    DrawBoxes,
    AnimButton,
    EditAnimBut,
    RotateButton,
    Dummy,Move,Rotate,Scale
    : PBoolean;
 //   JointButton: TSpeedButton;
    GlValueList: TValueListEditor;
    AnimBox: TComboBox;
    TrackPanel: TTrackPanel;
    TreeProgress:TProgressBar;
 //   ValueList: TValueListEditor;
    Status, StatusM: TStatusPanel;
    ClassTree: TTreeView;
    XLabel, XImageLab: TLabel;
    XImage: TImage;
    Handle: THandle;
    Canvas: TCanvas;
  end;

var
  W3D: boolean = true;
  WUM: boolean = false;
  WF: boolean = false;
  W4: boolean = false;
  WB: boolean = false;
  WR: boolean = false;
  WC: boolean = false;
  W3DGC: Boolean = false;
  Xbit: Integer;
  GLError: boolean = false;
  But:TXCtrls;
type

  TContainers = class;
  TContainer = class;

  TCntrSet = class
    constructor Create;
    destructor Destroy;override;
  public
    Point: Pointer;
    Size:Integer;
    Cntr:TContainer;
    procedure SetSize(NewSize:integer);
    procedure ClearIndex(DelIndex: integer);
    procedure ClearGraphSetIndex(DelIndex: integer);
    procedure InsertXGraph(OldIndex,NewIndex:integer;GUID:TGUID;NameID:Integer);
    procedure IncSize;
    procedure DecSize;
  end;

  TSetCntr = class
    constructor Create;
    destructor Destroy;override;
  public
    Point: Pointer;
    Size:Integer;
    Cntr:TContainer;
    XType: XValTypes;
    procedure DeleteElement(DelIndex: integer);
    procedure AddElement;
  end;

  TCntrVal = class
    constructor Create;
    destructor Destroy;override;
  public
    IdName:String;
    Point: Pointer;
    XType: XValTypes;
    XList: PXEnumStrings;
    XListSize: integer;
    Cntr: TContainer;
  end;

  TContainer = class
    constructor Create(_index:integer; Arr:TContainers; _point:Pointer);
    destructor Destroy; override;
    private
    Del: boolean;
    procedure ToDelete;
    procedure NoDelete(DelCntr:TContainer);
    public
    Index: integer;
    Point: Pointer; // ссылка на точку в памяти
    Size: Integer; // размер контейнера
    Update: Boolean; // обновлен
    CTNR: Boolean; // имеет заголовок
    Xtype: XTypes; // тип контейнера
    Name: String;
    CntrArr: TContainers;
    CntrSet: TCntrSet;
    Childs: array of TContainer;
    OldIndex: Integer; // старый индекс
    ReBuild: boolean; // флаг для перестройки
    isNew:Boolean; // флаг новых контейнеров;
    BaseIndex: Integer; //базовый индекс
    procedure GetXMem(_size: Integer);
    function NewCopy:Pointer;
    function AddChild(_index:integer):TContainer;
    function GetPoint:Pointer;
    procedure ClearChilds;
    procedure ClearAllChilds;
    function GetOffset(P:Pointer):Integer;
    function CopyBufTo(Buf:TMemoryStream;P:Pointer):Integer;
    procedure CopyBufFrom(Buf:TMemoryStream;P:Pointer);
    procedure WriteBuf(Buf:TMemoryStream);
    procedure WriteXArray(Arr: Pointer; Len, _Size: Integer);
    procedure WriteCNTR(Buf:TMemoryStream);
    procedure FreeXMem;
    procedure CutSize(P:Pointer);
    function BuildCntrArr(Cntrs: TContainers): TContainer;
    function  Copy(Cntrs:TContainers=nil):TContainer;
    function DelNoClone(BaseCntr:TContainer):Integer;
    procedure ViewTga(ImageT32: TImage; XGrid: Boolean; XLabel: TLabel);
    procedure SaveTGA(Name: string; Image32: TImage; XLabel: TLabel);
    function ImportXImage(Name: string): Boolean;
    procedure StripSetToTri;
    procedure TriToStripSet;
    procedure WeightSetToPalette;
    procedure FillColor(Num:Integer;Color:Byte);
  end;

//  XContainers = array of TContainer;

  TContainers = class(TObjectList)
    private
        function GetItems(Index: Integer): TContainer;
        procedure SetItems(Index: Integer; const Value: TContainer);
    public
        function FindNewIndex(OldIndex:Integer;New:Boolean): Integer;
        function FoundXType(XType:XTypes):Integer;
        procedure FreeDel;
        procedure ClearChilds;
        procedure ClearNames;
        procedure OffReBuild;
    property Items[Index: Integer]: TContainer read GetItems write SetItems; default;
  end;

function Byte128(_byte: Integer): Integer;
function TestByte128(var _p: Pointer): Integer;
procedure WriteXByte(var Memory: TMemoryStream; Val: Integer);
procedure WriteXByteP(var p: Pointer; Val: Integer);
function ReadName(var Stream: TMemoryStream): string;
procedure IncXValType(var p2:Pointer;XType:XValTypes);

implementation

uses XomMeshLib;

function Byte128(_byte: Integer): Integer;
begin
  asm
mov eax,_byte
mov ecx,128
cdq
div ecx
cmp eax,0
je @@no
add edx,128
@@no:
mov ecx,eax
imul ecx,256
add ecx,edx
mov result,ecx
end;
end;

function TestByte128(var _p: Pointer): Integer;
var
  Val, n: Integer;
begin
  n := 1;
  Val := Byte(_p^) and $7f;
  while ((Byte(_p^) shr 7) = 1) and (n < 4) do
  begin
    Inc(Longword(_p));
    Val := ((Byte(_p^) and $7F) shl (7 * n)) + Val;
    Inc(n);
  end;
  Inc(Longword(_p));
  Result := Val;
end;


procedure WriteXByte(var Memory: TMemoryStream; Val: Integer);
var
  byte0: Byte;
  HByte: Boolean;
begin
  Hbyte := true;
  while Hbyte do
  begin
    byte0 := Byte(Val);
    //     Hbyte:=byte((val shr 7)and 1);
    Hbyte := (Val shr 7) > 0;
    if Hbyte then
      byte0 := byte0 or $80;
    Memory.Write(byte0, 1);
    Val := Val shr 7;
  end;
end;

procedure WriteXByteP(var p: Pointer; Val: Integer);
var
  byte0: Byte;
  HByte: Boolean;
begin
  Hbyte := true;
  while Hbyte do
  begin
    byte0 := Byte(Val);
    Hbyte := (Val shr 7) > 0;
    if Hbyte then
      byte0 := byte0 or $80;
    Byte(p^) := byte0;
    Inc(Longword(p));
    Val := Val shr 7;
  end;
end;

function ReadName(var Stream: TMemoryStream): string;
var
  p: Pointer;
begin
  p := Pointer(Longword(Stream.Memory) + Stream.Position);
  Result := PChar(p);
  Stream.Position := Stream.Position + Length(Result) + 1;
end;

procedure IncXValType(var p2:Pointer;XType:XValTypes);
begin
      case XType of

      XBool,
      XByte:    Inc(Longword(p2));

      XString,
      XText,
      XIndex:   TestByte128(p2);

      X4Char,
      XFloat,
      XFFloat,
      XEnum:    Inc(Longword(p2), 4);
      XEnumByte:Inc(Longword(p2));
      XInt:     Inc(Longword(p2), 4);
      XCode:    Inc(Longword(p2), 4);
      XVectorR: Inc(Longword(p2), 4*3);
      XVector:  Inc(Longword(p2), 4*3);
      XSBound:  Inc(Longword(p2), 4*4);
      XVector4: Inc(Longword(p2), 4*4);
      XMatrix4: Inc(Longword(p2), 4*4*4);
      XMatrix3: Inc(Longword(p2), 4*3*4);
      XUInt:    Inc(Longword(p2), 2);
      XPoint:   Inc(Longword(p2), 4*2);
      XFColor:  Inc(Longword(p2), 4*3);
      XColor:   Inc(Longword(p2), 1*4);
      end;
end;

{       TCntrVal       }
constructor TCntrVal.Create;
begin
  inherited Create;
end;

destructor TCntrVal.Destroy;
begin
//  XList.Free;
  inherited;
end;
{}


{ TContainer }

constructor TContainer.Create(_index:Integer;Arr:TContainers;_point:Pointer);
begin
  inherited Create;
  CntrArr:=Arr;
  Index:=_index;
  Point:=_point;
end;

procedure TContainer.GetXMem(_size: Integer);
begin
    FreeXMem;
    Update := true;
    Point := AllocMem(_size);
    Size := _Size;
end;

function TContainer.NewCopy:Pointer;
var NewPoint:Pointer;
begin
      NewPoint := AllocMem(Size);
      Move(Point^, NewPoint^, Size);
      FreeXMem;
      Update := true;
      Point:=NewPoint;
      Result:=Point;
end;

procedure TContainer.FreeXMem;
begin
 if Update and (Point<>nil) then
      FreeMem(point);
end;

function TContainer.GetPoint:Pointer;
begin
  Result := Pointer(Longword(Point) + 3);
end;

function TContainer.AddChild(_index:integer):TContainer;
var
  Len: Integer;
begin
  Len := Length(Childs);
  SetLength(Childs, Len + 1);
  if _index<>0 then
        Childs[Len] := CntrArr[_index]
  else
        Childs[Len] := nil;
  Result:=Childs[Len];
end;

procedure TContainer.ClearChilds;
begin
  SetLength(Childs,0);
end;

function TContainer.Copy(Cntrs:TContainers=nil):TContainer;
var
NewPoint:Pointer;
begin
      NewPoint := AllocMem(Size);
      Move(Point^, NewPoint^, Size);
      Result:=TContainer.Create(Index,Cntrs,NewPoint);
      Result.Size:=Size;
      Result.CTNR:=CTNR;
      Result.Xtype:=Xtype;
      Result.Update:=true;
      Result.BaseIndex:=BaseIndex;
      if Cntrs<>nil then Result.isNew:=true;
end;

function TContainer.BuildCntrArr(Cntrs: TContainers):TContainer;
var
  i, Len, n: Integer;
  exist:boolean;
begin
  // проверка на уникальный класс
  Result:=nil;
  exist:=false;
  for i:=0 to Cntrs.Count-1 do
  begin
    if Cntrs[i].Index=Index then begin
    exist:=true;
    Result:= Cntrs[i];
    break end;
  end;
  // если он уникален, то добавляем его
  if not exist then begin
     n:=Cntrs.Add(Self.Copy);
     Cntrs[n].CntrArr:=Cntrs;
     Result:=Cntrs[n];
  // пробигаем по потомкам.
  Len := Length(Childs);
  SetLength(Result.Childs,Len);  // детей можно было не делать
  for i:=0 to Len-1 do
      if Childs[i]<>nil then begin
      Result.Childs[i]:=Childs[i].BuildCntrArr(Cntrs);
      end;
  end;
end;

procedure TContainer.ClearAllChilds;
var i:integer;
begin
  if Length(Childs) > 0 then begin
    for i := 0 to Length(Childs) - 1 do
      if Childs[i]<>nil then Childs[i].ClearAllChilds;
    ClearChilds;
  end;
end;

destructor TContainer.Destroy;
begin
    FreeXMem;
    ClearChilds;
    inherited Destroy;
end;

procedure TContainer.WriteCNTR(Buf:TMemoryStream);
var
p:pointer;
  begin
    if CTNR then
    begin
    //  p := PChar('CTNR');
      p := CtnrS;
      Buf.Write(p^, 4);
    end;

    Buf.Write(Point^, Size);
end;

function TContainer.GetOffset(P:Pointer):Integer;
begin
 Result:=Longword(P)-Longword(Point);
end;

function TContainer.CopyBufTo(Buf:TMemoryStream;P:Pointer):Integer;
var
 offset:Integer;
begin
 offset:=GetOffset(P);
 Buf.Write(Point^,offset);
 Result:=offset;
end;

procedure TContainer.CopyBufFrom(Buf:TMemoryStream;P:Pointer);
begin
 Buf.Write(P^,Size-GetOffset(P));
end;

procedure TContainer.WriteBuf(Buf:TMemoryStream);
var
  _Size:integer;
begin
  _Size := Buf.Position;
  GetXMem(_Size);
  Move(Buf.Memory^, Point^, _Size);
end;

procedure TContainer.CutSize(P: Pointer);
begin
   Size := GetOffset(P);
end;

procedure TContainer.WriteXArray(Arr: Pointer; Len, _size: Integer);
var
    NewPoint, p: Pointer;
begin
    GetXMem(Len * _size + 8);
    p := GetPoint;
    WriteXByteP(p, Len);
    Move(Arr^, p^, Len * _size);
    Inc(Longword(p), Len * _size);
    CutSize(p);
end;

var
globXGrid:boolean;
  // callback to fill image block from bgra block
procedure SetBitmap32bitBlock(const Handle: pointer; var BGRABlock: TBGRABlock; const X, Y: integer);
var
  Bitmap: TBitmap;
  Src, Dest: PBGRA;
  i, j, Width, Height: integer;
  Grid: Byte;
  Bgrid, Tgrid: Boolean;
  alfa, beta: Real;
begin
  Bitmap := TBitmap(Handle);
  Width := Bitmap.Width;
  Height := Bitmap.Height;


  Bgrid := false;
  Dest := nil;
  Src := @BGRABlock[0];


  Bgrid :=
        ((X - X mod 8) mod 16 = 0)
        xor
        ((Y - Y mod 8) mod 16 = 0);

  if not Bgrid then grid := 192 else grid := 255;

  for j := Y to Y+3 do
  begin
    if (j < Height) then Dest := pointer(integer(Bitmap.ScanLine[j]) + sizeof(TBGRA)*X);

    for i := X to X+3 do
    begin
     if (i < Width) and (j < Height) then begin
     if globXGrid then
          begin

          Dest.R := (Src.A * (Src.R - Grid) shr 8) + Grid;
          Dest.G := (Src.A * (Src.G - Grid) shr 8) + Grid;
          Dest.B := (Src.A * (Src.B - Grid) shr 8) + Grid;

          end else
       Dest^ := Src^
       end;

      inc(Dest);
      inc(Src);
    end;

  end;
end;

procedure TContainer.ViewTga(ImageT32: TImage; XGrid: Boolean;
  XLabel: TLabel);
label
  f24;
var
  VBuf, VBuf2: Pointer;
  w, h, i, j, IName, ISize, CntrIndx: Integer;
  b: TBitmap;
  p0, p1: PARGBA;
  p2, p4: PARGB;
  p3: PAB;
  Grid, Bsize: Byte;
  Bgrid, Is24Bit: Boolean;
  alfa, beta: Real;
  offsetbyte, Imap, itype: Integer;
  kImageFormat_P8: Boolean;
  Dxt1: boolean;
  Header: TDxtHeader;
  Buffer: TMemoryStream;
  DxtBlocks: pointer;


begin
  VBuf := GetPoint;
  IName := TestByte128(VBuf); // Name
  kImageFormat_P8:=false;
  // DeleteObject(ImageT32.Picture.Bitmap.Handle);
  //  ImageT32.Picture.Bitmap.Create;

  b := TBitmap.Create;//ImageT32.Picture.Bitmap;
  b.canvas.Brush.Style := bsSolid;
  b.canvas.Brush.Color := clBlack;
  w := Word(VBuf^);   // Width
  b.Width := w;
  Inc(Longword(VBuf), 2);
  h := Word(VBuf^);      // Height
  Inc(Longword(VBuf), 2);
  b.Height := h;

  Imap := Byte(VBuf^);    // MapLevels
  Inc(Longword(VBuf), 2);
  //  Is24Bit:=(byte(VBuf^)=0);  ????
  Inc(Longword(VBuf), 2);    // Flags
  if WC then Inc(Longword(VBuf), 4);
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize + 1);  // Strides
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize + 1);  // Offsets
  itype:=  Byte(VBuf^); // Format

  { 0 := GL_RGB8; kImageFormat_R8G8B8
    1,2 := GL_RGBA8; kImageFormat_A8R8G8B8
    3 :=  kImageFormat_X8R8G8B8
    4 := GL_RGBA //GL_UNSIGNED_SHORT_1_5_5_5_REV   kImageFormat_X1R5G5B5 ?
    5 := kImageFormat_A1R5G5B5 ? kImageFormat_R5G6B5
    6 := GL_ALPHA kImageFormat_A8
    7 := XBox // kImageFormat_P8
    8 :=  kImageFormat_P4
    9 := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  kImageFormat_DXT1
    10 := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT kImageFormat_DXT3
    11 := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT
    27 := GL_RGB16F kImageFormat_NgcRGBA8 ?
    28,31 := GL_RGBA16F
    33,36 := GL_DEPTH24_STENCIL8
  }
  { Worms 3D Image Format
   	0 = kImageFormat_R8G8B8
	1 = kImageFormat_A8R8G8B8
	2 = kImageFormat_X8R8G8B8
	3 = kImageFormat_X1R5G5B5
	4 = kImageFormat_A1R5G5B5
	5 = kImageFormat_R5G6B5
	6 = kImageFormat_A8
	7 = kImageFormat_P8
	8 = kImageFormat_P4
	9 = kImageFormat_DXT1
	10 = kImageFormat_DXT3
	11 = kImageFormat_NgcRGBA8
	12 = kImageFormat_NgcRGB5A3
	13 = kImageFormat_NgcR5G6B5
	14 = kImageFormat_NgcIA8
	15 = kImageFormat_NgcIA4
	16 = kImageFormat_NgcI8
	17 = kImageFormat_NgcI4
	18 = kImageFormat_NgcCI12A4
	19 = kImageFormat_NgcCI8
	20 = kImageFormat_NgcCI4
	21 = kImageFormat_NgcCMPR
	22 = kImageFormat_NgcIndirect
	23 = kImageFormat_P2P8
	24 = kImageFormat_P2P4
	25 = kImageFormat_Linear
	26 = kImageFormat_Count
  }
  {   Worms Revolution ImageFormat
  	0 = kImageFormat_R8G8B8
	1 = kImageFormat_A8R8G8B8
	2 = kImageFormat_X8R8G8B8
	3 = kImageFormat_X1R5G5B5
	4 = kImageFormat_A1R5G5B5
	5 = kImageFormat_R5G6B5
	6 = kImageFormat_A8
	7 = kImageFormat_P8
	8 = kImageFormat_P4
	9 = kImageFormat_DXT1
	10 = kImageFormat_DXT3
	11 = kImageFormat_DXT5
	12 = kImageFormat_NgcRGBA8
	13 = kImageFormat_NgcRGB5A3
	14 = kImageFormat_NgcR5G6B5
	15 = kImageFormat_NgcIA8
	16 = kImageFormat_NgcIA4
	17 = kImageFormat_NgcI8
	18 = kImageFormat_NgcI4
	19 = kImageFormat_NgcCI12A4
	20 = kImageFormat_NgcCI8
	21 = kImageFormat_NgcCI4
	22 = kImageFormat_NgcCMPR
	23 = kImageFormat_NgcIndirect
	24 = kImageFormat_P2P8
	25 = kImageFormat_P2P4
	26 = kImageFormat_Linear
	27 = kImageFormat_F16RGB
	28 = kImageFormat_F16RGBA
	29 = kImageFormat_F32RGB
	30 = kImageFormat_F32RGBA
	31 = kImageFormat_F16RG
	32 = kImageFormat_D16
	33 = kImageFormat_D24
	34 = kImageFormat_D32
	35 = kImageFormat_FD32
	36 = kImageFormat_D24S8
	37 = kImageFormat_A8R8G8B8_SCE
	38 = kImageFormat_X8R8G8B8_LE
	39 = kImageFormat_Count

        0 = kCompressionOpNone
	1 = kCompressionOpUseBest
	2 = kCompressionOpForceDXT1
	3 = kCompressionOpForceDXT3
	4 = kCompressionOpForceDXT5

}
  Dxt1 := false;
  case itype of
  7,19: begin //kImageFormat_P8
    kImageFormat_P8 := true;
  end;
  9,10,11: begin
    Dxt1:=true;
  end;
  end;
    if WR or Dxt1 then Inc(Longword(VBuf), 5);    //Compression //Modifiable
  Is24Bit := (itype = 0);
  Inc(Longword(VBuf), 4);
  //  ImageReady:=ImageReady and(typeimage=1);

  ISize := TestByte128(VBuf);  // Data
  VBuf2 := VBuf;
  Inc(Longword(VBuf2), ISize);
  CntrIndx := TestByte128(VBuf2); //Palette

  if Dxt1 then
  begin
    Buffer := TMemoryStream.Create;
    Dxt1 := itype=9; //(Header.dwFourCC = 'DXT1');
    Buffer.WriteBuffer(VBuf^,ISize);
    DxtBlocks := Buffer.Memory;
    DxtImageAlpha(DxtBlocks, Dxt1, w, h);

    // Flip
    CrystalDXT.DxtImageFlip(DxtBlocks, Dxt1, w, h);
    // Decompress
    try
      b.PixelFormat := pf32bit;
      globXGrid:=XGrid;
      DxtImageDecompress(DxtBlocks, Dxt1, w, h,
                         pointer(b), SetBitmap32bitBlock);
    except
      FreeAndNil(b);
    end;
    Buffer.Free;
    Xbit := 32;
  end

  else

  begin
  if not kImageFormat_P8 then
  begin
    if not Is24Bit then
    begin
      b.PixelFormat := pf32bit;
      //  VBuf:=pointer(Longword(Buf)+offsetbyte);
      for j := 0 to h - 1 do 
      begin
        p0 := b.scanline[h - 1 - j];
        p1 := Pointer(Longword(VBuf) + j * w * 4);
        for i := 0 to w - 1 do
        begin
          p0[i] := p1[i];
          if XGrid then
          begin
          Bgrid:=
                ((i - i mod 8) mod 16 = 0)
                xor
                ((j - j mod 8) mod 16 = 0);
          if not Bgrid then grid := 192 else grid := 255;

          p0[i].B := (p1[i].A * (p1[i].R - Grid) shr 8) + Grid;
          p0[i].G := (p1[i].A * (p1[i].G - Grid) shr 8) + Grid;
          p0[i].R := (p1[i].A * (p1[i].B - Grid) shr 8) + Grid;

          end
          else
          begin
            p0[i].b := p1[i].r;
            p0[i].r := p1[i].b;
          end;
        end;
      end;
      Xbit := 32;
    end
    else

    begin
      b.PixelFormat := pf24bit;
      //   VBuf:=pointer(Longword(Buf)+offsetbyte);
      for j := 0 to h - 1 do
      begin
        Pointer(p2) := Pointer(b.scanline[h - 1 - j]);
        p4 := Pointer(Longword(VBuf) + j * w * 3);
        for i := 0 to w - 1 do 
        begin
          p2[i] := p4[i];
          p2[i].b := p4[i].r;
          p2[i].r := p4[i].b;
        end;
      end;
      Xbit := 24;
    end;
 // end;
  end
  else
  begin  //kImageFormat_P8
    b.PixelFormat := pf32bit;
    p1    := Pointer(Longword(CntrArr[CntrIndx].point) + 11);
    Bgrid := false;
    for j := 0 to h - 1 do
    begin
      p0 := b.scanline[h - 1 - j];
      p3 := Pointer(Longword(VBuf) + j * w * 1);
      for i := 0 to w - 1 do
      begin
        p0[i] := p1[p3[i]];
        if XGrid then
        begin
          alfa := (p1[p3[i]].a / 256);
          beta := 1 - alfa;
          Bgrid:=
                ((i - i mod 8) mod 16 = 0)
                xor
                ((j - j mod 8) mod 16 = 0);
          p0[i].b := Round(p1[p3[i]].b * alfa + Grid * beta);
          p0[i].g := Round(p1[p3[i]].g * alfa + Grid * beta);
          p0[i].r := Round(p1[p3[i]].r * alfa + Grid * beta);
        end
        else
        begin
          //  p0[i].b:=p1[p3[i]].b;
         //   p0[i].g:=p1[p3[i]].g;
        end;
      end;
    end;

    Xbit := 8;
  end;
  end;
  ImageT32.Picture.Bitmap.Assign(b);
  B.Free;
  XLabel.Caption :=
    Format('XImage [%d] - %dx%dx%dbit%sMaps:%d Size:%d',
    [Index, w, h, Xbit, #13#10, Imap, ISize]);
end;

procedure TContainer.SaveTGA(Name: string; Image32: TImage; XLabel: TLabel);
var
  VirtualBufer: TMemoryStream;
  tga: TgaHead;
begin
  ViewTga(Image32, false, XLabel);
  VirtualBufer := TMemoryStream.Create;
  tga.zero := 0;
  tga.zero2 := 0;
  tga.zero3 := 0;
  tga.typeTGA := 2;
  tga.Width := Image32.Width;
  tga.Height := Image32.Height;
  if Image32.Picture.Bitmap.PixelFormat=pf24bit then
  tga.ColorBit := 24
  else
  tga.ColorBit := 32;
  VirtualBufer.Write(tga, SizeOf(tga) - 2);
  VirtualBufer.Write(Image32.Picture.Bitmap.scanline[tga.Height - 1]^,
    tga.Height * tga.Width * (tga.ColorBit div 8));
  VirtualBufer.SaveToFile(Name);
  VirtualBufer.Free;
end;



function TContainer.ImportXImage(Name: string): Boolean;
label
  ExitP;
var
  TGABuf, VBuf: Pointer;
  Iname, W, h, NumMaps: Integer;
  TgaH: TgaHead;

    p0: PARGB;
    p1: PARGBA;
    VirtualBufer: TMemoryStream;
    nbyte: Byte;
    MipXImage, RGBImage: Pointer;
    Maps, NMaps, Itype, i, j, wSize, Alpha, Compon, FullSize,
    Width, Height, offset: Integer;
  const
    zero: Integer = 0;

  function LoadTgaToMemeory(FileName: string): Pointer;
  var
    iFileHandle, iFileLength: Integer;
  begin
    Result:= nil;
    if FileExists(FileName) then
    begin
      iFileHandle := FileOpen(FileName, fmOpenRead);
      if iFileHandle > 0 then
      begin
        iFileLength := FileSeek(iFileHandle, 0, 2);
        FileSeek(iFileHandle, 0, 0);
        Result := AllocMem(iFileLength + 1);
        FileRead(iFileHandle, Result^, iFileLength);
        FileClose(iFileHandle);
      end;
    end
  end;

  procedure GetMipmap(var MipXImage: Pointer; RGBImage: Pointer;
    const TgaH: TgaHead; Width, Height, Compon: Integer);
  var 
    IFormat: Integer;
  begin
    IFormat := GL_RGBA;
    if Compon = 3 then
      IFormat := GL_RGB;
    if (TgaH.Width <> Width) and (TgaH.Height <> Height) then
      gluScaleImage(IFormat, TgaH.Width, TgaH.Height, GL_UNSIGNED_BYTE,
        RGBImage,
        Width, Height, GL_UNSIGNED_BYTE, MipXImage)
    else
      Move(RGBImage^, MipXImage^, TgaH.Width * TgaH.Height * Compon);
  end;


{00 00 00 01 80 00 80 00
01 00 00 00 01 80 01 00
00 01 00 00 00 00 00 00
00 00 80 80 03     }
  {}
begin
  Result := false;
  TGABuf := LoadTgaToMemeory(Name);
  if TGABuf = nil then
  begin
    MessageBox(But.Handle,
      PChar(Format('Can not open %s!!!', [Name])),
      PChar('Error'), MB_OK);
    goto ExitP;
  end;
  Move(TGABuf^, TgaH, SizeOf(tgaH) - 2);
  VBuf := GetPoint;
  IName := TestByte128(VBuf);
  w := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  h := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  NumMaps := Byte(VBuf^);
  Inc(Longword(VBuf), 2);
  if Word(VBuf^) > 0 then
    alpha := 32
  else 
    alpha := 24;

  if (TgaH.Width <> w) or (TgaH.Height <> h) or (tgaH.ColorBit <> alpha) then
    if MessageBox(But.Handle,
      PChar(Format('You sure replace Image %dx%dx%d to %dx%dx%d?',
      [w, h, alpha, TgaH.Width, TgaH.Height, tgaH.ColorBit])),
      PChar('Warning!!!'), MB_YESNO) = idNo then
      goto ExitP;

  if (Frac(log2(TgaH.Width)) <> 0) or (Frac(log2(TgaH.Height)) <> 0) then
  begin
    MessageBox(But.Handle,
      PChar(Format('Bad size %dx%d!!!', [TgaH.Width, TgaH.Height])),
      PChar('Error'), MB_OK);
    goto ExitP;
  end;

//  Result := MakeXImage(TGABuf, TgaH, Iname, NumMaps);

    VirtualBufer := TMemoryStream.Create;
    VirtualBufer.Write(zero, 3);
    WriteXByte(VirtualBufer, iName);//?
    VirtualBufer.Write(TgaH.Width, 2);
    VirtualBufer.Write(TgaH.Height, 2);
    if NumMaps = 1 then
      NMaps := 1
    else
    begin
      Maps  := Max(TgaH.Width, TgaH.Height);
      NMaps := Round(Log2(Maps)) + 1;
    end;
    VirtualBufer.Write(NMaps, 2);
    Itype := 0; 
    Compon := 3;
    Alpha := 0;
    if TgaH.ColorBit = 32 then
    begin
      Alpha  := 1;
      Itype  := 2;
      Compon := 4;
    end;

    //    ConvertRGBtoBGR
    RGBImage := Pointer(Longword(TGABuf) + 18);

    if Alpha = 0 then
      for j := 0 to TgaH.Height - 1 do
      begin
        p0 := Pointer(Longword(RGBImage) + j * TgaH.Width * Compon);
        for i := 0 to TgaH.Width - 1 do
        begin
          nbyte := p0[i].b;
          p0[i].b := p0[i].r;
          p0[i].r := nbyte;
        end;
      end
    else
      for j := 0 to TgaH.Height - 1 do
      begin
        p1 := Pointer(Longword(RGBImage) + j * TgaH.Width * Compon);
        for i := 0 to TgaH.Width - 1 do
        begin
          nbyte := p1[i].b;
          p1[i].b := p1[i].r;
          p1[i].r := nbyte;
        end;
      end;

    VirtualBufer.Write(Itype, 2);
    VirtualBufer.Write(NMaps, 1);
    Width := TgaH.Width;
    for i := 0 to NMaps - 1 do
    begin
      wSize := Compon * Width;
      VirtualBufer.Write(wSize, 4);
      Width := Width div 2;
      // if Width = 0 then Break;
    end;
    VirtualBufer.Write(NMaps, 1);
    offset := 0;
    Width := TgaH.Width;
    Height := TgaH.Height;
    for i := 0 to NMaps - 1 do
    begin
      VirtualBufer.Write(Offset, 4);
      Offset := offset + Compon * Width * Height;
      Width  := Width div 2;
      Height := Height div 2;
      if Height = 0 then
        Height := 1;
      //   If Width=0 then break;
    end;

    VirtualBufer.Write(Alpha, 4);
    FullSize := Offset;
    WriteXByte(VirtualBufer, FullSize);
    Width := TgaH.Width;
    Height := TgaH.Height;
    MipXImage := AllocMem(Width * Height * Compon);
    for i := 0 to NMaps - 1 do
    begin
      if (Width=0) then Width:=1;
      if (Height=0) then Height:=1;
      GetMipmap(MipXImage, RGBImage, TgaH, Width, Height, Compon);
      VirtualBufer.Write(MipXImage^, Width * Height * Compon);
      if ((Width = 1) and (Height = 1)) then
        Break;
      Width  := Width div 2;
      Height := Height div 2;
    end;
    VirtualBufer.Write(zero, 1);
    FreeMem(MipXImage);

    WriteBuf(VirtualBufer);
    VirtualBufer.Free;
    Result:=true;


  ExitP:
  FreeMem(TGABuf);
end;

function TContainer.DelNoClone(BaseCntr: TContainer):Integer;
var i:integer;
begin
 // помечаем все конейнеры и их детей на удаление
 ToDelete;
 // пробегаемся по дереву предка, находя всех клонов, кроме выделеного
 BaseCntr.NoDelete(self);
 // удаляем все уникальные контейнеры ?
 Result:=Index;
// Del:=false; //?
end;

procedure TContainer.ToDelete;
var i:integer;
begin
 for i:=0 to Length(Childs)-1 do
   if Childs[i]<>nil then Childs[i].ToDelete;
 Del:=true;
end;

procedure TContainer.NoDelete(DelCntr: TContainer);
var i:integer;
begin
if self=DelCntr then exit;
 for i:=0 to Length(Childs)-1 do
   if Childs[i]<>nil then Childs[i].NoDelete(DelCntr);
 Del:=false;
end;

procedure TContainer.StripSetToTri;
var
p2,p:Pointer;
SizeBox:TBox;
  IndFace:IFace;
  Face: AFace;
  i,j, FaceNum, Num: Integer;
FaceCntr, VertexCntr, NormalCntr, ColorCntr, TextureCntr, WeightCntr: Integer;
Val:integer;
begin

  p2 := GetPoint;
    // get Faces
  Inc(Longword(p2));
  Inc(Longword(p2),2);
  FaceCntr := TestByte128(p2);   //5  XIndexSet
  Inc(Longword(p2), 8);
  VertexCntr := TestByte128(p2);
  NormalCntr := TestByte128(p2);
  ColorCntr := TestByte128(p2);
  TextureCntr := TestByte128(p2);
  WeightCntr  := TestByte128(p2);
  Move(p2^, SizeBox, 2 * 12);

  p2 := CntrArr[FaceCntr].GetPoint;
  FaceNum      := TestByte128(p2);
  SetLength(IndFace,FaceNum);
  Move(p2^, IndFace[0], FaceNum*2);

  Face:=TMesh.FaceFromStrip(IndFace);  // Gen

  Num := Length(Face);
  CntrArr[FaceCntr].GetXMem(Num * 6 + 8);
  p := CntrArr[FaceCntr].GetPoint;
  WriteXByteP(p, Num * 3);
  for j := 0 to Num - 1 do
  begin
    Move(Face[j], p^, 6);
    Inc(Longword(p), 6);
  end;
  CntrArr[FaceCntr].CutSize(p);
// запись
  GetXMem(Size+8);
  val:=1;
  Move(val, Point^, 1);
  p2 := GetPoint;

  WriteXByteP(p2, FaceCntr); //5  XIndexSet
  Inc(Longword(p2), 4);
  Move(Num, p2^, 2);
  Inc(Longword(p2), 4);

  WriteXByteP(p2, VertexCntr);
  WriteXByteP(p2, NormalCntr);
  WriteXByteP(p2, ColorCntr);
  WriteXByteP(p2, TextureCntr);
  WriteXByteP(p2, WeightCntr);
  Move(SizeBox, p2^, 2 * 12);
  Inc(Longword(p2), 2*12);
  Inc(Longword(p2), 4);
  CutSize(p2);
  XType:=XIndexedTriangleSet;
end;

procedure TContainer.TriToStripSet;
var
p2,p:Pointer;
SizeBox:TBox;
  IndFace:IFace;
  Face: AFace;
  i,j, FaceNum, Num: Integer;
FaceCntr, VertexCntr, NormalCntr, ColorCntr, TextureCntr, WeightCntr: Integer;
Val:integer;
begin

  p2    := GetPoint;
  FaceCntr := TestByte128(p2);   //5
  Inc(Longword(p2), 4);
  Inc(Longword(p2), 4);
  VertexCntr := TestByte128(p2);
  NormalCntr := TestByte128(p2);
  ColorCntr := TestByte128(p2);
  TextureCntr := TestByte128(p2);
  WeightCntr  := TestByte128(p2);
  Move(p2^, SizeBox, 2 * 12);

  p2 := CntrArr[FaceCntr].GetPoint;
  FaceNum := TestByte128(p2) div 3;
  SetLength(Face, FaceNum);
  for j := 0 to FaceNum - 1 do
  begin
      Move(p2^, Face[j], 6);
      Inc(Longword(p2), 6);
  end;

  IndFace:=TMesh.FaceToStrip(Face);  // Gen

  Num := Length(IndFace);
  CntrArr[FaceCntr].GetXMem(Num * 2 + 8);
  p := CntrArr[FaceCntr].GetPoint;
  WriteXByteP(p, Num);
  Move(IndFace[0], p^, Num*2);
  Inc(Longword(p), Num*2);
  CntrArr[FaceCntr].CutSize(p);
 // запись
  GetXMem(Size+4);
  val:=1;
  Move(val, Point^, 1);
  p2 := GetPoint;
  Move(val, p2^, 1);   Inc(Longword(p2), 1);
  Move(Num, p2^, 2);   Inc(Longword(p2), 2);
  WriteXByteP(p2, FaceCntr); //5  XIndexSet
  Inc(Longword(p2), 4);
  val:=1;
  Move(val, p2^, 4);   Inc(Longword(p2), 4);

  WriteXByteP(p2, VertexCntr);
  WriteXByteP(p2, NormalCntr);
  WriteXByteP(p2, ColorCntr);
  WriteXByteP(p2, TextureCntr);
  WriteXByteP(p2, WeightCntr);
  Move(SizeBox, p2^, 2 * 12);
  Inc(Longword(p2), 2*12);
  Inc(Longword(p2), 4);
  CutSize(p2);

  XType:=XIndexedTriangleStripSet;  
end;

procedure TContainer.FillColor(Num: Integer; Color: Byte);
var
Color4u :AUColor;
FillColor4U:TUColor;
i:integer;
begin
      SetLength(Color4u,Num);
        FillColor4U[0]:=Color;
        FillColor4U[1]:=Color;
        FillColor4U[2]:=Color;
        FillColor4U[3]:=255;
      for i:=0 to Num-1 do
        Color4u[i]:=FillColor4U;
      WriteXArray(@Color4u[0], Num, 4);
end;


procedure TContainer.WeightSetToPalette;
var
p2,p3,p:Pointer;
k,i,j, oldk,  NumVertex, NumWeight, NumBones: Integer;
Val:integer;
w:Single;
Weight: AAVal;
findbone:boolean;
begin
  p2 := GetPoint;
  // считывание весов
      NumBones := Word(p2^);       // количество костей 2 байта
      Inc(Longword(p2), 2);
      NumWeight:=TestByte128(p2);     // не известный индекс, размер?
      NumVertex :=NumWeight div NumBones;
      SetLength(Weight, NumVertex, NumBones);
      for j := 0 to NumVertex - 1 do
      begin
        Move(p2^, Weight[j][0], NumBones * 4); // считывание для каждого вертекса, n костей
        Inc(Longword(p2), NumBones * 4);
      end;
{
286 (vertexes)
572 (windex)
array of byte
2 (word)
572 (windex)
array of single
}
  // запись весов
  NumWeight := NumVertex*2;
  GetXMem(4+NumWeight+2+4+NumVertex*2*4);
  p2 := GetPoint;
  WriteXByteP(p2, NumWeight);  // количество точек
  p3:=p2;
  Inc(Longword(p3), NumWeight);  // конец точек
  val:=2;
  Move(val, p3^, 2);  // не известные 2 байта
  Inc(Longword(p3), 2);
  WriteXByteP(p3, NumWeight);  // количество точек
      for j := 0 to NumVertex - 1 do
      begin
        k:=0;
        for i:=0 to NumBones-1 do
          if (Weight[j][i]>0) then begin k:=i; Break; end;

        Move(k, p2^, 1);
        w:=Weight[j][k];
        Move(w, p3^, 4); // Вес точки 1
        Inc(Longword(p2));
        Inc(Longword(p3), 4);
        oldk:=k;
        Inc(k);

        if (k=NumBones) then
          k:=0
        else

          for i:=k to NumBones-1 do
            if (Weight[j][i]>0) then begin k:=i; Break; end;  

        Move(k, p2^, 1);
        w:=Weight[j][k];
        Move(w, p3^, 4);  // Вес точки 2
        Inc(Longword(p2));
        Inc(Longword(p3), 4);
     //if WUM and (k>2) then begin

      end;
  CutSize(p3);
  XType:=XPaletteWeightSet;
end;

{ TContainers }

procedure TContainers.ClearChilds;
var i:integer;
begin
 for i:=1 to Count-1 do
   if (Items[i]<>nil) then Items[i].ClearChilds;
end;

procedure TContainers.ClearNames;
var i:integer;
begin
 for i:=1 to Count-1 do
   if (Items[i]<>nil) then Items[i].Name:='';
end;

function TContainers.FindNewIndex(OldIndex: Integer;New:Boolean): Integer;
var
i:integer;
begin
 Result:=0;
if OldIndex=0 then exit;
if New then begin    // если контейнер новый
 for i:=1 to Count-1 do // ищем среди новых индексов
        if (Items[i].isNew)and (Items[i].OldIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                break;
                end;
end else
begin
 for i:=1 to Count-1 do // ищем среди старых индексов
        if  (not Items[i].isNew)and (Items[i].OldIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                exit;
                end;
 // если не нашли, значит он удален, поэтому ищем тот который будет вместо него, среди новых.
 for i:=1 to Count-1 do // ищем среди новых базовый
       if (Items[i].isNew)and(Items[i].BaseIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                exit;
                end;
 // если и среди новых его нет, то исключительная ситуация.
 Result:=-1;
end;

end;


function TContainers.FoundXType(XType: XTypes): Integer;
var
i:integer;
found:boolean;
begin
 Result:=0;
 found:=false;
 for i:=1 to Count-1 do begin
        if (not found) and (Items[i].Xtype=XType) then found:=true;
        if (found) and ((Items[i].Xtype<>XType)or (i=Count-1)) then
                begin
                Result:=i;
                break;
                end;
        end;
end;

procedure TContainers.FreeDel;
var i:integer;
begin
 for i:=0 to Count-1 do
   if (Items[i]<>nil)and (Items[i].Del) then begin
   SetLength(Items[i].Childs,0);
   Items[i]:=nil;
   end;
 Pack;
end;

function TContainers.GetItems(Index: Integer): TContainer;
begin
 Result := TContainer(inherited GetItem(Index));
end;

procedure TContainers.OffReBuild;
var
i:integer;
begin
 for i:=0 to Count-1 do
                begin
                Items[i].ReBuild:=false;
                Items[i].isNew:=false;
                Items[i].BaseIndex:=0;
                end;
end;

procedure TContainers.SetItems(Index: Integer; const Value: TContainer);
begin
 inherited SetItem(Index, Value);
end;



{ TCntrSet }

constructor TCntrSet.Create;
begin
  inherited Create;
end;

procedure TCntrSet.DecSize;
begin
SetSize(Size-1);
end;

destructor TCntrSet.Destroy;
begin

  inherited;
end;

procedure TCntrSet.IncSize;
begin
SetSize(Size+1);
end;

procedure TCntrSet.InsertXGraph(OldIndex,NewIndex:integer;GUID:TGUID;NameID:Integer);
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  TestByte128(Pnt);
  for indx:=0 to Size-1 do begin
  oldP:=Pnt;
  Inc(Longword(Pnt), 16);
  Index:=TestByte128(Pnt);
  TestByte128(Pnt);
  if Index=OldIndex then begin
        
        VirtualBufer := TMemoryStream.Create;
        Cntr.CopyBufTo(VirtualBufer,oldP);

        VirtualBufer.Write(GUID,16);
        WriteXByte(VirtualBufer,NewIndex);
        WriteXByte(VirtualBufer,NameID);

        Cntr.CopyBufFrom(VirtualBufer,oldP);
        Cntr.WriteBuf(VirtualBufer);
        VirtualBufer.Free;
        Point:=Pointer(Longword(Cntr.Point)+offset);
        break;
  end;

  end;
end;
end;

procedure TCntrSet.SetSize(NewSize: integer);
var
indx, NewIndex: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  Size:=NewSize;
  VirtualBufer := TMemoryStream.Create;
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;   // точка на значение
  Cntr.CopyBufTo(VirtualBufer,Pnt);
  WriteXByte(VirtualBufer,Size);
  TestByte128(Pnt);
  Cntr.CopyBufFrom(VirtualBufer,Pnt);
  Cntr.WriteBuf(VirtualBufer);
  VirtualBufer.Free;
  Point:=Pointer(Longword(Cntr.Point)+offset);
end;

end;

procedure TCntrSet.ClearIndex(DelIndex: integer);
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  TestByte128(Pnt);
  for indx:=0 to Size-1 do begin

  oldP:=Pnt;
  Index:=TestByte128(Pnt);

  if Index=DelIndex then begin
        VirtualBufer := TMemoryStream.Create;
        Cntr.CopyBufTo(VirtualBufer,oldP);
        TestByte128(oldP);
        Cntr.CopyBufFrom(VirtualBufer,oldP);
        Cntr.WriteBuf(VirtualBufer);
        VirtualBufer.Free;
        Point:=Pointer(Longword(Cntr.Point)+offset);
        break;
  end;

  end;
end;

end;

procedure TCntrSet.ClearGraphSetIndex(DelIndex: integer);
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  TestByte128(Pnt);
  for indx:=0 to Size-1 do begin

  oldP:=Pnt;
  Inc(Longword(Pnt), 16);
  Index:=TestByte128(Pnt);
  TestByte128(Pnt);
  if Index=DelIndex then begin
        VirtualBufer := TMemoryStream.Create;
        Cntr.CopyBufTo(VirtualBufer,oldP);
        Inc(Longword(oldP), 16);
        TestByte128(oldP);
        TestByte128(oldP);
        Cntr.CopyBufFrom(VirtualBufer,oldP);
        Cntr.WriteBuf(VirtualBufer);
        VirtualBufer.Free;
        Point:=Pointer(Longword(Cntr.Point)+offset);
        break;
  end;

  end;
end;

end;


{ TSetCntr }

procedure TSetCntr.AddElement;
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin

  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  OldPnt:=Point;
  TestByte128(Pnt);
  NewPnt:=Pnt;
  for indx:=0 to Size-1 do begin
        IncXValType(Pnt,XType);
        if indx=0 then _Size:=Longword(Pnt)-Longword(NewPnt);
        end;
  oldP:=Pnt;

  Size:=Size+1;
  VirtualBufer := TMemoryStream.Create;
  Cntr.CopyBufTo(VirtualBufer,OldPnt);
  WriteXByte(VirtualBufer,Size);
  VirtualBufer.WriteBuffer(NewPnt^,_Size);
  Cntr.CopyBufFrom(VirtualBufer,NewPnt);
  Cntr.WriteBuf(VirtualBufer);
  VirtualBufer.Free;
  Point:=Pointer(Longword(Cntr.Point)+offset);

end;

end;

constructor TSetCntr.Create;
begin
  inherited Create;
end;


procedure TSetCntr.DeleteElement(DelIndex: integer);
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  OldPnt:=Point;
  TestByte128(Pnt);
  NewPnt:=Pnt;
  for indx:=0 to Size-1 do begin

  oldP:=Pnt;
  IncXValType(Pnt,XType);

  if indx=DelIndex then begin
        VirtualBufer := TMemoryStream.Create;
        Cntr.CopyBufTo(VirtualBufer,OldPnt);
        Size:=Size-1;
        _Size:=Longword(oldP)-Longword(NewPnt);
        WriteXByte(VirtualBufer,Size);
        VirtualBufer.WriteBuffer(NewPnt^,_Size);
        Cntr.CopyBufFrom(VirtualBufer,Pnt);
        Cntr.WriteBuf(VirtualBufer);
        VirtualBufer.Free;
        Point:=Pointer(Longword(Cntr.Point)+offset);
        break;
  end;

  end;
end;

end;

destructor TSetCntr.Destroy;
begin

  inherited;
end;


end.
