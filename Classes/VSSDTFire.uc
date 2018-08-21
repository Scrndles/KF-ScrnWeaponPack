class VSSDTFire extends KFShotgunFire;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone


simulated function InitEffects()
{
    super.InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
        return;
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
    // Draw shell ejects
    if (ShellEjectEmitter != None )
    {
        Canvas.DrawActor( ShellEjectEmitter, false, false, Weapon.DisplayFOV );
    }
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

    if (ShellEjectEmitter != None)
    {
        ShellEjectEmitter.Trigger(Weapon, Instigator);
    }
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (ShellEjectEmitter != None)
        ShellEjectEmitter.Destroy();
}


simulated function bool AllowFire()
{
    if(KFWeapon(Weapon).bIsReloading)
        return false;
    if(KFPawn(Instigator).SecondaryItem!=none)
        return false;
    if(KFPawn(Instigator).bThrowingNade)
        return false;

    if(KFWeapon(Weapon).MagAmmoRemaining < 1)
    {
        if( Level.TimeSeconds - LastClickTime>FireRate )
        {
            LastClickTime = Level.TimeSeconds;
        }

        if( AIController(Instigator.Controller)!=None )
            KFWeapon(Weapon).ReloadMeNow();
        return false;
    }

    return super(WeaponFire).AllowFire();
}

function float MaxRange()
{
    return 25000;
}


defaultproperties
{
     StereoFireSoundRef="ScrnWeaponPack_SND.VSS.VSS_Fire"
     FireSoundRef="ScrnWeaponPack_SND.VSS.VSS_Fire"
     NoAmmoSoundRef="KF_RifleSnd.Rifle_DryFire"

     ShellEjectClass=Class'ROEffects.KFShellEjectMac'
     ShellEjectBoneName="Shell_eject"
     RecoilRate=0.100000
     maxVerticalRecoilAngle=600
     maxHorizontalRecoilAngle=200
     FireAimedAnim="Iron_Idle"
     ProjPerFire=1
     ProjSpawnOffset=(X=0,Y=0,Z=0)
     bWaitForRelease=True
     bModeExclusive=False
     TransientSoundVolume=2.800000
     FireLoopAnim=
     FireForce="ShockRifleFire"
     FireRate=0.150000
     AmmoClass=Class'ScrnWeaponPack.VSSDTAmmo'
     ShakeRotMag=(X=100.000000,Y=100.000000,Z=500.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     //ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.000000)
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'ScrnWeaponPack.VSSDTBullet'
     BotRefireRate=0.650000
     FlashEmitterClass=Class'ScrnWeaponPack.MuzzleFlash3rdVSSDT'
     aimerror=1.000000
     Spread=0.000000
}
