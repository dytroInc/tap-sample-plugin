package com.github.dytroInc.sample.listeners

import org.bukkit.event.EventHandler
import org.bukkit.event.Listener
import org.bukkit.event.player.PlayerJoinEvent

class SampleListener : Listener {
    @EventHandler
    fun join(e: PlayerJoinEvent) {}
}