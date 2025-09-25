extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -300.0
@onready var audio_jump: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	if not Global.clear:
		if not Global.die:
			if not is_on_floor():
				velocity += get_gravity() * delta

			# Handle jump.
			if Input.is_action_just_pressed("ui_up") and is_on_floor():
				velocity.y = JUMP_VELOCITY

			# Get the input direction and handle the movement/deceleration.
			var direction := Input.get_axis("ui_left", "ui_right")
			
			if direction < 0:
				animated_sprite.flip_h = true
			elif direction > 0:
				animated_sprite.flip_h = false
				
			if is_on_floor():
				if direction == 0:
					animated_sprite.play("idle")
				else:
					animated_sprite.play("run")
			else:
				animated_sprite.play("jump")
			
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
			move_and_slide()
			
		else:
			# 죽음 애니메이션은 한 번만 실행
			if animated_sprite.animation != "die":
				animated_sprite.play("die")
				collision_shape.disabled = true
	else:
		# 클리어 상태일 때
		if not is_on_floor():
			# 공중이면 중력만 적용해서 바닥까지 떨어지게 함
			velocity += get_gravity() * delta
			move_and_slide()
		else:
			# 바닥에 닿은 후에만 엔딩 애니 실행
			if animated_sprite.animation != "end":
				animated_sprite.play("end")
				collision_shape.disabled = true


# 애니메이션 종료 시 처리
#func _on_animated_sprite_2d_animation_finished() -> void:
	#match animated_sprite.animation:
		#"die":
			#print("죽음 애니 끝! → 씬 리로드")
		#"end":
			#print("끝 애니 끝! → 클리어 처리")
