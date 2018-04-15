use v6;
use Box2D;
use NativeCall;
use Test;

plan 1;

# Define the gravity vector.
my $gravity = Box2D::Vec2.new(0.0, -10.0);

# Construct a world object, which will hold and simulate the rigid bodies.
my $world = Box2D::World.new($gravity);

# Define the ground body.
my $groundBodyDef = Box2D::BodyDef.new;
$groundBodyDef.position_x =   0.0e0;
$groundBodyDef.position_y = -10.0e0;

# Call the body factory which allocates memory for the ground body
# from a pool and creates the ground box shape (also from a pool).
# The body is also added to the world.
my $groundBody = $world.CreateBody($groundBodyDef);

# Define the ground box shape.
my $groundBox = Box2D::PolygonShape.new;

# The extents are the half-widths of the box.
$groundBox.SetAsBox(50.0, 10.0);

# Add the ground fixture to the ground body.
$groundBody.CreateFixture($groundBox, 0.0e0);

# Define the dynamic body. We set its position and call the body factory.
my $bodyDef   = Box2D::BodyDef.new();           # b2BodyDef bodyDef;
$bodyDef.type = Box2D::BodyType::dynamicBody;   # bodyDef.type = b2_dynamicBody;
$bodyDef.position_x = 0.0e0;                    # bodyDef.position.Set(0.0f, 4.0f);
$bodyDef.position_y = 4.0e0;
my $body      = $world.CreateBody($bodyDef);    # b2Body* body = world.CreateBody(&bodyDef);

# Define another box shape for our dynamic body.
my $dynamicBox = Box2D::PolygonShape.new;       # b2PolygonShape dynamicBox;
$dynamicBox.SetAsBox(1.0, 1.0);                 # dynamicBox.SetAsBox(1.0f, 1.0f);

# Define the dynamic body fixture.
my $fixtureDef = Box2D::FixtureDef.new(         # b2FixtureDef fixtureDef;
    :shape($dynamicBox.Clone($world.m_blockAllocator)), # fixtureDef.shape = &dynamicBox;
);

# Set the box density to be non-zero, so it will be dynamic.
$fixtureDef.density = 1.0e0;                    # fixtureDef.density = 1.0f;

# Override the default friction.
$fixtureDef.friction = 0.3e0;                   # fixtureDef.friction = 0.3f;

# Add the shape to the body.
$body.CreateFixture($fixtureDef);               # body->CreateFixture(&fixtureDef);

# Prepare for simulation. Typically we use a time step of 1/60 of a
# second (60Hz) and 10 iterations. This provides a high quality simulation
# in most game scenarios.
my num32 $timeStep           = 1.0e0 / 60.0e0;  # float32 timeStep = 1.0f / 60.0f;
my int32 $velocityIterations = 6;               # int32 velocityIterations = 6;
my int32 $positionIterations = 2;               # int32 positionIterations = 2;
my $last-position            = '';

# This is our little game loop.
loop (my int32 $i = 0; $i < 60; ++$i)
{
    # Instruct the world to perform a single step of simulation.
    # It is generally best to keep the time step and iterations fixed.
    $world.Step($timeStep, $velocityIterations, $positionIterations);

    # Now print the position and angle of the body.
    my $position = $body.GetPosition();         # b2Vec2 position = body->GetPosition();
    my $angle    = $body.GetAngle();            # float32 angle = body->GetAngle();

    diag($last-position = sprintf("%4.2f %4.2f %4.2f", $position.x, $position.y, $angle)); # ,,
}

is $last-position, '0.00 1.01 0.00', 'Body felt to expected position';

# When the world destructor is called, all bodies and joints are freed. This can
# create orphaned pointers, so be careful about your world management.
